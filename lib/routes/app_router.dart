import 'package:go_router/go_router.dart';
import 'package:hola_mundo/form_view.dart';
import 'package:hola_mundo/nueva_vista.dart';
import 'package:hola_mundo/views/future%20(lista%20estudiantes)/future_view.dart';
import 'package:hola_mundo/views/home_view.dart';
import 'package:hola_mundo/views/isolate%20(tarea%20pesada)/isolate_view.dart';
import 'package:hola_mundo/views/meals/meal_detail_view.dart';
import 'package:hola_mundo/views/meals/meal_list_view.dart';
import 'package:hola_mundo/views/profile_view.dart';
import 'package:hola_mundo/views/settings_view.dart';
import 'package:hola_mundo/views/timer%20(temporizadores)/timer_view.dart';

final GoRouter appRouter = GoRouter(
  //* CLASE EN DONDE VAN DEFINIDAS LAS RUTAS DE LA APP
  routes: [
    GoRoute(
      path: '/', //* EL "/" INDICA QUE ES LA PANTALLA INICIAL
      builder:
          (context, state) =>
              const HomeView(), //* IMPORTANTE QUE DE PRIMERO ESTÉ LA PANTALLA INICIAL
    ),
    GoRoute(
      //* SE DEFINE LA URL DE LA RUTA
      path: '/settings',
      builder: (context, state) => const SettingsView(), // Usa SettingsView
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileView(), // Usa ProfileView
    ),
    GoRoute(path: '/form', builder: (context, state) => const FormView()),
    GoRoute(
      path: '/nueva-vista/:texto', // Ruta con parámetro
      builder: (context, state) {
        final texto = state.pathParameters['texto'] ?? '';
        return NuevaVista(textoRecibido: texto);
      },
    ),
    //!Ruta para la pagina FLista de estudiantes
    GoRoute(
      path: '/future',
      name: 'future',
      builder: (context, state) => const FutureView(),
    ),
    //!Ruta para la pagina Temporizadores
    GoRoute(
      path: '/timer',
      name: 'timerView',
      builder: (context, state) => const TimerView(),
    ),
    //!Ruta para la pagina Tarea pesada
    GoRoute(
      path: '/isolate',
      name: 'isolate',
      builder: (context, state) => const IsolateView(),
    ),
    //! Rutas para el manejo de las comidas
    GoRoute(
      path: '/meals',
      name: 'meals',
      builder: (context, state) => const MealListView(),
    ),
    GoRoute(
      path: '/meal/:id',
      name: 'mealDetail',
      builder:
          (context, state) => MealDetailView(id: state.pathParameters['id']!),
    ),
  ],
);
