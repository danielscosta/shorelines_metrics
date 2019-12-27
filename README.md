# ShorelinesMetrics

This is an API-only application. To Solve the problem proposed on https://shorelinesoftware.com/software-engineer-interfaces/


## To up the system

Create database 

`$ docker-compose run web mix ecto.create`

To run test, coveralls and credo

`$ docker-compose run --rm test`

Run release of the phoenix server:

`$ docker-compose up release`

