# Este modulo me permite manejar facilmente columnas para ordenar un listado de modelos
# expone un unico metodo publico, #sorts, que recibe el nombre "tabletizado" (ver ActiveSupport::Inflector#tableize)
# por ej: "students" (de todas formas, siempre se invoca a #tableize, ...)
# y, opcionalmenteuna lista de campos "ordenables", la cual, si no se define, se inicializa como todos los atributos
# del modelo en cuestion.
# De estas columnas, la primera es la que define el orden por defecto
#
# La idea es incluir este modulo en un Controller; el modulo va a agregar metodos para generar cabeceras de
# tablas HTML siguiendo la convencion "sort_modelos_by_atriubto", donde modelos es el que se pasa como parametro
# al llamar a #sorts, y atributo cada uno de los campos
#
# Estos metodos "sort_by" son wrappers de ActionView::Helpers::UrlHelper#link_to, y esperan encontrar las traducciones
# en el locale activo siguiendo la convencion "tabletizado.fields.atributo", por ej: "students.fields.name"
#
# Los links son generados con la opcion "remote: true", ya que la idea es reflejar los cambios por AJAX. Los links
# generados incluyen los parametros de ordenamiento en la URL; estos son:
# ":order" => columna por la que se ordena. Se aplica una sanitizacion respecto de las columnas indicadas al invocar
#             a #sorts; si el valor del parametro no esta inlcuido en esa lista, se devuelve la columna por defecto
#
# ":direction" => los unicos dos posibles valores son "asc" y "desc". Tambien son sanitizados
#
# Ejemplo:
#
# class StudentsController < ApplicationController
#   include SortsModels
#
#   sorts :students, :surname, name,
# end
#
# Esto indica que el recurso "students" es ordenable, y que la columna por defecto es :surname; los campos para los
# cuales se generan metodos son :surname y :name
#
# Esto genera los siguientes metodos (que tambien se pueden utilizar en las vistas)
#
# #sort_students_by_name
# #sort_students_by_surname
# #students_sort_params => contiene los parametros de ordenacion, extraidos de la url, listos para enviar al
#                          metodo #order de ActiveRecord
# #students_sort_column? => true si en el request existe params[:sort] y ademas supera la sanitizacion
# #students_sort_direction? => true si en el request existe params[:direction] y ademas supera la sanitizacion
# #students_sort_column => valor de params[:sort]; si no existe, devuelve columna por defecto
# #students_sort_direction => valor de params[:direction]; si no existe, devuelve "asc"
#
# Los helpers que generan URL tambien son capaces de detectar cual es la columna por la cual se esta ordenando
# actualmente, y tambien la direccion(ascendenteo descendente).
# Esto permite agregar un icono (una flecha) que indica cual es la columna por la cual se esta ordenando, y
# tambien la direccion de la misma (usa iconos de FontAwesome 4)
#
# El controller definido arriba se terminaria usando asi:
#
#  def index
#    @students = Student.order(students_sort_params)
#  end
#

module SortsModels
  extend ActiveSupport::Concern

  module ClassMethods
    def sorts(model, *fields)
      resource = model.to_s.tableize
      @@fields ||= ActiveSupport::HashWithIndifferentAccess.new
      @@fields[resource] = model_fields(resource, fields)
      create_sort_by_methods(resource, @@fields[resource])
      create_helpers(resource)
    end

    private
      def define_helper_method(name, &block)
        helper_method define_method(name, &block)
      end

      def create_helpers(resource)
        define_helper_method "#{resource}_sort_column?" do
          @@fields[resource].include?(send("#{resource}_sanitized_sort_params")[:sort])
        end

        define_helper_method "#{resource}_default_sort_column" do
          @@fields[resource].first
        end

        define_helper_method "#{resource}_sanitized_sort_params" do
          params.permit(:sort, :direction)
        end

        define_helper_method "#{resource}_sort_column" do
          send("#{resource}_sort_column?") ?
            send("#{resource}_sanitized_sort_params")[:sort] :
            send("#{resource}_default_sort_column")
        end

        define_helper_method "#{resource}_sort_direction?" do
          %w[asc desc].include?(send("#{resource}_sanitized_sort_params")[:direction])
        end

        define_helper_method "#{resource}_sort_direction" do
          send("#{resource}_sort_direction?") ?
            send("#{resource}_sanitized_sort_params")[:direction] :
            send("#{resource}_default_sort_direction")
        end

        define_helper_method "#{resource}_default_sort_direction" do
          'asc'
        end

        define_helper_method "#{resource}_sort_params" do
          send("#{resource}_sort_column") + ' ' + send("#{resource}_sort_direction")
        end

        define_helper_method "#{resource}_sort_form_inputs" do
          ctx = view_context
          fields = ''
          fields << (ctx.hidden_field_tag :sort, send("#{resource}_sort_column")) if send("#{resource}_sort_column?")
          fields << (ctx.hidden_field_tag :direction, send("#{resource}_sort_direction")) if send("#{resource}_sort_direction")
          fields.html_safe
        end

        define_method :header do |name, field|
          h = I18n.t("activerecord.attributes.#{name.singularize}.#{field}")
          return h unless field == send("#{resource}_sort_column")
          "#{h} #{icon(field)}".html_safe
        end

        define_method :url do |field|
          { q: filter, sort: field, direction: direction(field) }
        end

        define_method :direction do |field|
          field == send("#{resource}_sort_column") && send("#{resource}_sort_direction") == "asc" ? "desc" : "asc"
        end

        define_method :icon do |field|
          icon_arrow = direction(field) == "asc" ? "down" : "up"
          view_context.tag.i class: "fas fa-sort-alpha-#{icon_arrow}"
        end
      end

      def create_sort_by_methods(resource, fields)
        fields.each do |field|
          method_name = "sort_#{resource}_by_#{field}".to_sym
          define_method(method_name) do
            view_context.link_to header(resource, field), url(field)
          end

          helper_method method_name
        end
      end

      def model_fields(resource, fields = [])
        return get_model_class(resource.classify).column_names if fields.blank?
        fields.map {|f| f.to_s }
      end

      def get_model_class(klass)
        Object.const_get klass
      end
  end
end