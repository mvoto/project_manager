## Project Management Tool

This is a Rails REST API sample to handle projects.

### Endpoints

The API provides the following endpoints:

#### - GET /api/v1/projects

List of projects with related notes

##### parameters:

* **page:** current page of pagination

#### - POST /api/v1/projects

Creates a project

##### parameters:

* **name:** the name of the project
* **conclusion_date:** the deadline date of the project(expected format: yyyy/mm/dd)
* **client_id:** id of the client that project belongs to

#### - PUT/PATCH /api/v1/projects/:id

Updates the project by the given `id`

##### parameters:

* **name:** the name of the project
* **conclusion_date:** the deadline date of the project(expected format: yyyy/mm/dd)
* **client_id:** id of the client that project belongs to

#### - PATCH /api/v1/projects/:id/finish

Updates the state to `concluded` of the project by the given `id`

#### - PATCH /api/v1/archive

Updates the `archive` attribute to `true` and the `archived_date` of the project by the given `ids`
This works as a soft deletion

##### parameters:

* **ids:** id or ids of the project that might be archived

#### - POST  /api/v1/notes

Creates a note for a specific project
If you would like to change the state of a project, you could create a note with the following content:

``` mark as completing```

The example used `completing` as a project's state, but you could use any of the following states:

`started`, `approving`, `building`, `completing`, `concluded`

##### parameters:

* **project_id:** id of the project that the note belongs to
* **content:** the content text of the note

#### - PATCH /api/v1/notes/:id/archive

Updates the `archive` attribute to `true` and the `archived_date` of the note by the given `id`
This works as a soft deletion


### TODO List

- Add authentication by token
- Run more tests to improve rack-attack
- Double check CORS settings
- Generate some kind of documentation such as swagger-docs for example
- Refactor the projects controller specs to use some shared examples
