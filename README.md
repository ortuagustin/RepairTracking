# RepairTracking
## Métodos Ágiles para Aplicaciones Web

Este proyecto consiste en una aplicación web para gestionar reparaciones de diferentes tipos de artefactos/máquinas, los cuales pertenecen a los distintos clietnes que se van registrando en el sistema. A su vez, los clientes pueden hacer un seguimiento del estado de la reparación online, a través de un código que identifica a su artefacto/máquina.

### Alumnos

* Ortu, Agustín
* Calabrese, Julieta
* Muñoz, Rocío

### Preparando el ambiente:

#### Ambiente Ruby

* El proyecto se dessarrolló usando [**Ruby**](https://www.ruby-lang.org) 2.5.3p105 (2018-10-18 revision 65156)
* Se utilizó [**Ruby on Rails**](https://rubyonrails.org) 5.2.1 como framework de desarrollo
* Se utilizó [VueJS](https://vuejs.org) como framework de desarrollo para el frontend
* La base de datos utiliazda es [**SQLite3**](https://www.sqlite.org) para desarrollo; [**PostgreSQL**](https://www.postgresql.org) para producción
* **Dependencias**: Como en la mayoria de los proyectos Rails, son gestionadas usando [Bundler](https://github.com/bundler/bundler). Las mas destacadas son:
  - [Rails](https://github.com/rails/rails)
  - [Bootstrap 4.1](https://getbootstrap.com)
  - [VueJS](https://vuejs.org)
  - [Devise](https://github.com/plataformatec/devise)
  - [Validates](https://github.com/kaize/validates)
  - [Faker](https://github.com/stympy/faker)
  - [Kaminari](https://github.com/kaminari/kaminari)
  - [FontAwesome](https://fontawesome.com/)

1. Clonar el repositorio:

```bash
  git clone https://github.com/ortuagustin/RepairTracking.git
  cd RepairTracking
```

2. Ejecutar bundler para instalar las dependencias de Ruby:

```bash
  bundle
```

> En desarrollo no es necesario instalar **postgres**: `bundle install --without production`

3. Ejecutar yarn para instalar las dependencias de JavaScript:

```bash
  yarn install
```

4. Es posible que se necesiten dependencias adicionales para las bases de datos; en sistemas linux, se debe
  - SQLite (desarrollo y tests):

  ```bash
    apt install sqlite3
    apt install libsqlite3-dev
  ```
  - PostgreSQL (producción):

  ```bash
    apt install libpq-dev
  ```

5. Configurar la base de datos:
  - Para crear la BD, ejecutar: `rails db:migrate`
  - Para inicializar la BD con los *seeds*, es decir, un set de datos inicial, ejecutar `rails db:seed`

6. Se utiliza [Webpacker](https://github.com/rails/webpacker) para los assets utilizados en el frontend; correr en el directorio raiz del proyecto:
  - Desarrollo

```bash
  ./bin/webpack --watch --colors --progress
```
  - Producción

```bash
  ./bin/webpack
```

7. Ejecución: Correr el servidor: `rails s` y acceder a la [aplicación](http://localhost:3000)

8. Para correr los tests: `rails t`

### Heroku

Ésta aplicación fue desplegada a la plataforma [Heroku](http://heroku.com), podés verla siguiendo [este link](https://repair-tracking.herokuapp.com)
