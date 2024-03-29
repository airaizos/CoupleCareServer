# Backend API con Vapor

Este repositorio alberga un proyecto de servidor backend desarrollado en el lenguaje Swift utilizando la librería [Vapor](https://docs.vapor.codes/es/). Su propósito principal es ofrecer una API RESTful con endpoints específicos que interactúan con una base de datos para proporcionar datos a una aplicación móvil.

## Características Principales

**Lenguaje y Framework**: El proyecto está escrito en Swift, aprovechando las capacidades de la librería Vapor para la implementación del servidor.
**Base de Datos**: Utiliza SQLite como sistema de gestión de bases de datos, con esquemas definidos mediante migraciones de modelos en Vapor.
**Endpoints RESTful**: Proporciona endpoints del tipo GET para obtener elementos desde la base de datos y endpoints del tipo POST para recibir sugerencias de nuevos elementos por parte de los usuarios.

## Estructura del Proyecto

El proyecto se organiza en torno a las siguientes funcionalidades principales:

**Migraciones de Base de Datos**: Define y gestiona la estructura de la base de datos mediante migraciones de modelos en Vapor para garantizar la integridad y consistencia de los datos.
**Endpoints de API**: Implementa endpoints específicos que permiten la interacción entre la aplicación móvil y el backend, incluyendo operaciones para obtener datos existentes y recibir sugerencias de nuevos elementos.

## Ambientes de Desarrollo

**Este proyecto cuenta con dos ambientes de bases de datos**: uno destinado para pruebas (testing) y otro para producción (production). Estos ambientes ofrecen la posibilidad de validar y realizar pruebas en un entorno controlado antes de desplegar cambios en la versión de producción.

## Resources

La API contiene listados sobre sugerencias de actividades que realizar en pareja, clasificadas por categorías y tags. Los dailies son sugerencias de acciones unipersonales de detalles que tener con tu pareja.
El endpoint POST permite recibir sugerencias.
Se pueden obtener las ultimas activiades y dailies a partir de un índice dado. 

GET http://127.0.0.1:8080/testing/currentversion
GET http://127.0.0.1:8080/testing/categories 
GET http://127.0.0.1:8080/testing/tags
GET http://127.0.0.1:8080/testing/activities
GET http://127.0.0.1:8080/testing/dailies

LATEST
GET http://127.0.0.1:8080/testing/latest/categories/{index}
GET http://127.0.0.1:8080/testing/latest/tags/{index}
GET http://127.0.0.1:8080/testing/latest/quotes/{index}
GET http://127.0.0.1:8080/testing/latest/activitiesdetail/{index}

RANDOM
GET http://127.0.0.1:8080/testing/random/daily


SUGGESTIONS
POST http://127.0.0.1:8080/testing/suggested
