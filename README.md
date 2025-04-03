# Taller: Consumo de API pública con Flutter

Aplicación Flutter que demuestra:
Cómo consumir una API pública (The Meal DB) para mostrar recetas de cocina,
implementando navegación entre pantallas y manejo de estado.

## Funcionalidades
### Consumo de API REST
- Listado de recetas obtenidas de The Meal DB API
- Detalle completo de cada receta

### Navegación entre pantallas
- Listado a detalle usando go_router

### Manejo de estado
- Carga de datos con FutureBuilder
- Manejo de errores

### Variables de entorno
- Configuración de URLs de API usando .env

## Widgets utilizados
### Listado de recetas
- FutureBuilder
- CircularProgressIndicator
- ListView.builder
- Card

### Detalle de receta
- SingleChildScrollView
- Chip
- Image.network

### Navegación
- go_router
- Paso de parámetros

### Archivo .env (Crear en raíz del proyecto)
- MEAL_API_URL=https://www.themealdb.com/api/json/v1/1/

## Clonar el Repositorio
- git clone https://github.com/SergioAlarcon09/Talleres_Flutter/tree/Taller_Consumo_API.git

## Instalar dependencias
- flutter pub get

## Ejecutar en Chrome
- flutter run -d chrome

SERGIO IVÁN ALARCÓN PEÑA - 230221028 UCEVA
