import 'package:go_router/go_router.dart';
import 'package:hola_mundo/form_view.dart';
import 'package:hola_mundo/nueva_vista.dart';
import 'package:hola_mundo/views/home_view.dart';
import 'package:hola_mundo/views/profile_view.dart';
import 'package:hola_mundo/views/settings_view.dart';

final GoRouter appRouter = GoRouter(   //* CLASE EN DONDE VAN DEFINIDAS LAS RUTAS DE LA APP
  routes: [
    GoRoute(
      path: '/',   //* EL "/" INDICA QUE ES LA PANTALLA INICIAL
      builder: (context, state) => const HomeView(), //* IMPORTANTE QUE DE PRIMERO ESTÉ LA PANTALLA INICIAL
    ),
    GoRoute(      //* SE DEFINE LA URL DE LA RUTA
      path: '/settings',    
      builder: (context, state) => const SettingsView(), // Usa SettingsView
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileView(), // Usa ProfileView
    ),
    GoRoute(
      path: '/form',
      builder: (context, state) => const FormView(),
    ),
    GoRoute(
      path: '/nueva-vista/:texto', // Ruta con parámetro
      builder: (context, state) {
        final texto = state.pathParameters['texto'] ?? '';
        return NuevaVista(textoRecibido: texto);
      }
    ),
  ],
);
