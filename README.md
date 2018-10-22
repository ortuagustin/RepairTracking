# RepairTracking
## Métodos Ágiles para Aplicaciones Web

Este proyecto consiste en una aplicación web para gestionar reparaciones de diferentes tipos de artefactos/máquinas, los cuales pertenecen a los distintos clietnes que se van registrando en el sistema. A su vez, los clientes pueden hacer un seguimiento del estado de la reparación online, a través de un código que identifica a su artefacto/máquina.

### Alumnos

* Ortu, Agustín
* Calabrese, Julieta
* Muñoz, Rocío

### Preparando el ambiente:

#### Ambiente Ruby

* El proyecto se dessarrolló usando [**Ruby**](https://www.ruby-lang.org/) 2.5.1p57 (2018-03-29 revision 63029) pero deberia ser compatible con cualquier Ruby >= 2.x*
* Se utilizó [**Ruby on Rails**](https://rubyonrails.org/) 5.2.1 como framework de desarrollo
* La base de datos utiliazda es [**SQLite3**](https://www.sqlite.org)
* **Dependencias**: Como en la mayoria de los proyectos Rails, son gestionadas usando [Bundler](https://github.com/bundler/bundler). Las mas destacadas son:
  - [Rails](https://github.com/rails/rails)
  - [Bootstrap 4.1](https://getbootstrap.com)
  - [Devise](https://github.com/plataformatec/devise)
  - [Validates](https://github.com/kaize/validates)

1. Clonar el repositorio:

```bash
  git clone https://github.com/ortuagustin/RepairTracking.git
  cd RepairTracking
```

2. Ejecutar bundler para instalar las dependencias de Ruby:

```bash
  bundle
```

3. Es posible que se necesiten dependencias adicionales para las bases de datos; en sistemas linux, instalar **SQLite3**

```bash
  apt install sqlite3
  apt install libsqlite3-dev
```

4. Configurar la base de datos:
  - Para crear la BD, ejecutar: `rails db:migrate`
  - Para inicializar la BD con los *seeds*, es decir, un set de datos inicial, ejecutar `rails db:seed`

5. Ejecución: Correr el servidor: `rails s` y acceder a la [aplicación](http://localhost:3000). Se puede ingresar como administrador utilizando las credenciales: **usuario:** `admin`, **password**: `admin`

6. Para correr los tests: `rails t`
