import 'package:get/get.dart';

class MyLocalizations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "app_name": "Pomo Flutter",
          "get_started": "Get Started!",
          "next": "Next",
          "first_time_first_body": "Easy task & work management with pomo",
          "first_time_second_body": "Track your productivity & gain insights",
          "first_time_third_body": "Take a break and enjoy your coffee",
          "lets_in": "Let's you in",
          "sing_in_with_google": "Sign in with Google",
          "sing_in_with_github": "Sign in with Github",
          "sing_in_with_email": "Sign in with Email",
          "dont_have_account": "Don't have an account?",
          "sign_up": "Sign up",
          "sign_in": "Sign in",
          "already_have_account": "Already have an account?",
          "create_account": "Create an account",
          "sing_up": "Sign up",
          "or": "Or continue with",
          "accept_terms_and_conditions": "I accept the terms and conditions",
          "email": "Email",
          "password": "Password",
          "confirm_password": "Confirm password",
          "login_with_email": "Login yo your account",
          "forgot_password": "Forgot password?",
          "name_error":
              "Name must be at least 3 characters and without special characters",
          "email_error": "Email is not valid",
          "pass_error": "Password must be at least 6 characters",
          "confirm_pass_error": "Passwords do not match",
          "recover_password": "Recover password",
          "email_verification": "Email verification",
          "email_verification_text":
              "Check your email inbox and verify your account to continue.",
          "check_email_verification": "Continue",
          "not_received_email_verification":
              "Haven't received the verification email?",
          "resend_email_verification": "Resend email verification",
          "good_night": "Good night",
          "good_morning": "Good morning",
          "good_afternoon": "Good afternoon",
          "good_evening": "Good evening",
          "start_your_day": "It's going to be a great day, let's start!",
          "starting_your_daily_task": "You can do it! Let's go for it!",
          "keep_going": "Keep it up! You've already come a long way",
          "almost_there": "You've already passed the middle! Let's go!",
          "you_can_do_it": "You're almost there! Let's go!",
          "you_did_it": "You did it! Congratulations!",
          "statics_title": "Your Progress",
          "task_form_title": "New Task",
          "profile_title": "Your Profile",
          "calendar_title": "Calendar",
          "timer_title": "Timer",
          "task_completed": "Task completed!",
          "completed_tasks": "{completed} of {total} completed!",
          "today_task": "Today's Tasks",
          "see_all": "See All",
          "clear_done_tasks": "Clear finished",
          "add_new_task": "Add new",
          "mark_all_as_done": "Mark all as done",
          "no_task": "No tasks for today...",
          "task_form_button_clear": "Clear form",
          "task_form_button_save": "Save task",
          "task_form_input_title": "Task title",
          "task_form_input_description": "Task description",
          "task_form_input_date": "Task date",
          "task_form_input_time": "Task time",
          "task_form_input_category": "Task category",
          "task_form_input_color": "Task color",
          "task_form_input_count_working_session": "Working sessions",
          "task_form_input_time_working_session": "Working time",
          "task_form_input_time_break_session": "Break time",
          "task_form_input_time_long_break_session": "Long break time",
          "task_form_input_save_in_device_calendar":
              "Save in the device calendar",
          "red_name": "Red",
          "orange_name": "Orange",
          "yellow_name": "Yellow",
          "green_name": "Green",
          "blue_name": "Blue",
          "purple_name": "Purple",
          "pink_name": "Pink",
          "work_name": "Work",
          "personal_name": "Personal",
          "shopping_name": "Shopping",
          "others_name": "Others",
          "task_name_error":
              "Name must not be empty and have less than 20 characters",
          "task_description_error":
              "Description must not be empty and have less than 100 characters",
          "default_working_config": "Default working configuration",
          "reset_config": "Reset configuration",
          "save_config": "Save configuration",
          "error_save_config_web":
              "The option to save the configuration is not available in the web version",
          "user_config": "User configuration",
          "logout": "Logout",
          "aparence_config": "Appearance configuration",
          "sessions_now": "{completed} of {total} sessions",
          "delete_task": "Delete task",
          "delete_task_message": "Are you sure you want to delete this task?",
          "confirm": "Confirm",
          "cancel": "Cancel",
          "task_stopped": "Task stopped",
          "congratulations_title": "Congratulations!",
          "congratulations_body":
              "You have successfully completed all of today's pomodoro tasks! Great job!",
          "view_statistics": "View statistics",
          "go_back": "Go back",
          "break": "Break",
          "today_statistics": "Today's statistics",
          "month_statistics": "Month statistics",
          "success_save_config": "Configuration saved successfully",
          "login_success": "Login success",
          "passwords_not_match": "Passwords do not match",
          "register_success": "Register success",
          "login_google_success": "Login with Google success",
          "password_reset_send_success": "Password reset send success",
          "comments": "Comments",
          "no_comments": "No comments",
          "add_comment": "Add comment",
          "add_comment_message": "Add a comment to this task",
          "comment": "Comment",
          "delete_comment": "Delete comment",
          "delete_comment_message":
              "Are you sure you want to delete this comment?",
          "autherror_email-already-in-use":
              "The email address is already in use by another account.",
          "autherror_invalid-email": "The email address is badly formatted.",
          "autherror_operation-not-allowed":
              "The email/password accounts are not enabled.",
          "autherror_weak-password":
              "The password must be 6 characters long or more.",
          "autherror_user-disabled":
              "The user corresponding to the given email has been disabled.",
          "autherror_user-not-found":
              "There is no user corresponding to the given email.",
          "autherror_wrong-password":
              "The password is invalid or the user does not have a password.",
          "autherror_too-many-requests":
              "Too many unsuccessful login attempts. Please try again later.",
          "autherror_invalid-login-credentials":
              "Invalid login credentials. Please try again.",
          "autherror_unknown": "Unknown error. Please try again.",
          "education_name": "Education",
          "finance_name": "Finance",
          "health_name": "Health & Wellness",
          "home_name": "Home",
          "privacy_policy": "Privacy policy",
          "privacy_policy_info_title": "Website/app information",
          "privacy_policy_info_body":
              "This website is owned by Sergio de Iscar Valera.\nemail: seroigres888@gmail.com",
          "privacy_policy_data_title": "Type of data collected",
          "privacy_policy_data_body":
              "The data collected is the minimum necessary for the operation of the application.\n\nThe data collected is:\n- Username\n- Email\n- Password\n- Tasks\n- Comments\n- User configuration\n- Task configuration\n- Statistics\n\nThe collected data is not shared with third parties.\nThe collected data is stored in the Google database securely encrypted.",
          "privacy_policy_purpose_title": "Purpose of the collection",
          "privacy_policy_purpose_body":
              "The collected data is used for the operation of the application.\n\nThe collected data is used for:\n- User authentication\n- Task creation\n- Comment creation\n- Statistics creation\n- Configuration creation\n- Task configuration creation\n- Sending promotional emails from the application itself (never third-party advertising)\n\nThe collected data will never be shared with third parties or used for other purposes.",
          "privacy_policy_third_title": "Third parties",
          "privacy_policy_third_body":
              "The collected data is not shared with third parties.\nThe collected data is stored in the Google database securely encrypted.\nThe only third-party services involved are Google authentication.\n\nThe data collected by these services is:\n- Username\n- Email\n- Password\n\nThe data collected by these services is used for:\n- User authentication\n\nThe collected data will never be shared with third parties or used for other purposes.",
          "privacy_policy_security_title": "Security",
          "privacy_policy_security_body":
              "The collected data is stored in the Google database securely encrypted.",
          "privacy_policy_rights_title": "Rights",
          "privacy_policy_rights_body":
              "Application users have the right to:\n- Access their personal data\n- Rectify their personal data\n- Delete their personal data\n- Limit the processing of their personal data\n- Object to the processing of their personal data\n- Carry their personal data\n\nTo exercise these rights, users can contact the owner of the website/app via email.",
          "privacy_policy_updates_title": "Updates",
          "privacy_policy_updates_body":
              "We reserve the right to make the modifications that we consider appropriate to the website without prior notice, being able to change, delete or add both the contents and services provided through it and the way in which they are presented.\nOn the other hand, we may update these terms and conditions. The modifications will come into effect from the moment of their publication.",
          "forgot_password_body":
              "Don't worry, we'll help you recover it.\nJust enter your email and we'll send you a link so you can reset your password.",
          "delete_account": "Delete account",
          "delete_account_body":
              "Are you sure you want to delete your account?",
          "error_deleting_account":
              "Error deleting account, to delete the account you must be logged in previously.",
          "delete_account_success": "Account deleted successfully",
          "minute_unit": "min",
          "pomodoro_session_unit": "session/s",
          "task_form_success_add_calendar_event":
              "Event added to the device calendar correctly",
          "task_form_error_calendar_event":
              "Error of the event to the device calendar",
          "task_form_success_remove_calendar_event":
              "Event removed from the device calendar correctly",
          "task_form_error_time":
              "The task time cannot be earlier than the current time",
          "task_form_input_end_date_title": "Task end date (optional)",
          "task_form_input_date_end": "Task end date",
          "task_form_input_time_end": "Task end time",
          "edit_task": "Edit task",
          "edit_task_message": "Are you sure you want to edit this task?",
          "edit_task_submessage":
              "(If you want to start the task click on the play)",
        },
        'es_ES': {
          "app_name": "Pomo Flutter",
          "get_started": "¡Empezemos!",
          "next": "Siguiente",
          "first_time_first_body":
              "Gestión fácil de tareas y trabajos con pomo",
          "first_time_second_body":
              "Realice un seguimiento de su productividad y obtenga información",
          "first_time_third_body": "Tómate un descanso y disfruta de tu café",
          "lets_in": "Vamos a empezar",
          "sing_in_with_google": "Inicia sesión con Google",
          "sing_in_with_github": "Inicia sesión con Github",
          "sing_in_with_email": "Inicia sesión con Email",
          "dont_have_account": "¿No tienes una cuenta?",
          "sign_up": "Regístrate",
          "sign_in": "Iniciar sesión",
          "already_have_account": "¿Ya tienes una cuenta?",
          "create_account": "Crea una cuenta",
          "sing_up": "Regístrate",
          "or": "O continua con",
          "accept_terms_and_conditions": "Acepto los términos y condiciones",
          "email": "Email",
          "password": "Contraseña",
          "confirm_password": "Confirmar contraseña",
          "login_with_email": "Inicia sesión en tu cuenta",
          "forgot_password": "¿Olvidaste tu contraseña?",
          "name_error":
              "El nombre debe tener al menos 3 caracteres y sin caracteres especiales",
          "email_error": "El email no es válido",
          "pass_error": "La contraseña debe tener al menos 6 caracteres",
          "confirm_pass_error": "Las contraseñas no coinciden",
          "recover_password": "Recuperar contraseña",
          "email_verification": "Verificación de email",
          "email_verification_text":
              "Revisa la bandeja de entrada de tu email y verifica tu cuenta para poder continuar.",
          "check_email_verification": "Continuar",
          "not_received_email_verification":
              "¿No has recibido el email de verificación?",
          "resend_email_verification": "Reenviar email de verificación",
          "good_night": "Buenas noches",
          "good_morning": "Buenos días",
          "good_afternoon": "Buenas tardes",
          "good_evening": "Buenas noches",
          "start_your_day": "¡Va a ser un gran día, empezemos!",
          "starting_your_daily_task": "¡Tú puedes! ¡Vamos a por ello!",
          "keep_going": "¡Sigue así! Ya has avanzado mucho",
          "almost_there": "¡Ya has pasado la mitad! ¡Vamos!",
          "you_can_do_it": "¡Ya casi lo tienes! ¡Vamos!",
          "you_did_it": "¡Lo has conseguido! ¡Enhorabuena!",
          "statics_title": "Tu Progreso",
          "task_form_title": "Nueva Tarea",
          "profile_title": "Tu Perfil",
          "calendar_title": "Calendario",
          "timer_title": "Temporizador",
          "task_completed": "¡Tarea completada!",
          "completed_tasks": "¡{completed} de {total} completadas!",
          "today_task": "Tareas de hoy",
          "see_all": "Ver Todas",
          "clear_done_tasks": "Borrar completadas",
          "add_new_task": "Añadir nueva",
          "mark_all_as_done": "Marcar todas como completadas",
          "no_task": "No hay tareas para hoy...",
          "task_form_button_clear": "Limpiar formulario",
          "task_form_button_save": "Guardar tarea",
          "task_form_input_title": "Título de la tarea",
          "task_form_input_description": "Descripción de la tarea",
          "task_form_input_date": "Fecha de la tarea",
          "task_form_input_time": "Hora de la tarea",
          "task_form_input_category": "Categoría de la tarea",
          "task_form_input_color": "Color de la tarea",
          "task_form_input_count_working_session": "Sesiones de trabajo",
          "task_form_input_time_working_session": "Tiempo de trabajo",
          "task_form_input_time_break_session": "Tiempo de descanso",
          "task_form_input_time_long_break_session": "Tiempo de descanso largo",
          "task_form_input_save_in_device_calendar":
              "Guardar en el calendario del dispositivo",
          "red_name": "Rojo",
          "orange_name": "Naranja",
          "yellow_name": "Amarillo",
          "green_name": "Verde",
          "blue_name": "Azul",
          "purple_name": "Morado",
          "pink_name": "Rosa",
          "work_name": "Trabajo",
          "personal_name": "Personal",
          "shopping_name": "Compras",
          "others_name": "Otros",
          "task_name_error":
              "El nombre debe no estar vacío y tener menos de 20 caracteres",
          "task_description_error":
              "La descripción debe no estar vacía y tener menos de 100 caracteres",
          "default_working_config": "Configuración de trabajo por defecto",
          "reset_config": "Restablecer configuración",
          "save_config": "Guardar configuración",
          "error_save_config_web":
              "La opción de guardar la configuración no está disponible en la versión web",
          "user_config": "Configuración de usuario",
          "logout": "Cerrar sesión",
          "aparence_config": "Configuración de apariencia",
          "sessions_now": "{completed} de {total} sesiones",
          "delete_task": "Borrar tarea",
          "delete_task_message":
              "¿Estás seguro de que quieres borrar esta tarea?",
          "confirm": "Confirmar",
          "cancel": "Cancelar",
          "task_stopped": "Tarea detenida",
          "congratulations_title": "¡Enhorabuena!",
          "congratulations_body":
              "¡Has completado con éxito todas las tareas pomodoro de hoy! ¡Buen trabajo!",
          "view_statistics": "Ver estadísticas",
          "go_back": "Volver ",
          "break": "Descanso",
          "today_statistics": "Estadísticas de hoy",
          "month_statistics": "Estadísticas del mes",
          "success_save_config": "Configuración guardada correctamente",
          "login_success": "Inicio de sesión correcto",
          "passwords_not_match": "Las contraseñas no coinciden",
          "register_success": "Registro correcto",
          "login_google_success": "Inicio de sesión con Google correcto",
          "password_reset_send_success":
              "Envío de restablecimiento de contraseña correcto",
          "comments": "Comentarios",
          "no_comments": "No hay comentarios",
          "add_comment": "Añadir comentario",
          "add_comment_message": "Añade un comentario a esta tarea",
          "comment": "Comentario",
          "delete_comment": "Borrar comentario",
          "delete_comment_message":
              "¿Estás seguro de que quieres borrar este comentario?",
          "autherror_email-already-in-use":
              "La dirección de correo electrónico ya está siendo utilizada por otra cuenta.",
          "autherror_invalid-email":
              "La dirección de correo electrónico está mal formateada.",
          "autherror_operation-not-allowed":
              "Las cuentas de correo electrónico / contraseña no están habilitadas.",
          "autherror_weak-password":
              "La contraseña debe tener 6 caracteres o más.",
          "autherror_user-disabled":
              "El usuario correspondiente al correo electrónico dado ha sido deshabilitado.",
          "autherror_user-not-found":
              "No hay ningún usuario correspondiente al correo electrónico dado.",
          "autherror_wrong-password":
              "La contraseña no es válida o el usuario no tiene contraseña.",
          "autherror_too-many-requests":
              "Demasiados intentos de inicio de sesión fallidos. Vuelve a intentarlo más tarde.",
          "autherror_invalid-login-credentials":
              "Credenciales de inicio de sesión no válidas. Inténtalo de nuevo.",
          "autherror_unknown": "Error desconocido. Inténtalo de nuevo.",
          "education_name": "Educación",
          "finance_name": "Finanzas",
          "health_name": "Salud y bienestar",
          "home_name": "Hogar",
          "privacy_policy": "Política de privacidad",
          "privacy_policy_info_title": "Información del sitio web/app",
          "privacy_policy_info_body":
              "Este sitio web es propiedad de Sergio de Iscar Valera.\ncorreo: seroigres888@gmail.com",
          "privacy_policy_data_title": "Tipo de datos recopilados",
          "privacy_policy_data_body":
              "Los datos recopilados son los mínimos necesarios para el funcionamiento de la aplicación.\n\nLos datos recopilados son:\n- Nombre de usuario\n- Email\n- Contraseña\n- Tareas\n- Comentarios\n- Configuración de usuario\n- Configuración de tareas\n- Estadísticas\n\nLos datos recopilados no se comparten con terceros.\nLos datos recopilados se almacenan en la base de datos de Google encrptados de forma segura.",
          "privacy_policy_purpose_title": "Finalidad de la recopilación",
          "privacy_policy_purpose_body":
              "Los datos recopilados se utilizan para el funcionamiento de la aplicación.\n\nLos datos recopilados se utilizan para:\n- Autenticación de usuario\n- Creación de tareas\n- Creación de comentarios\n- Creación de estadísticas\n- Creación de configuraciones\n- Creación de configuraciones de tareas\n- Envio correos promocionales de la pripia aplicación (nunca publicidad de terceros)\n\nNunca se compartirán los datos recopilados con terceros ni se utilizarán para otros fines.",
          "privacy_policy_third_title": "Terceros",
          "privacy_policy_third_body":
              "Los datos recopilados no se comparten con terceros.\nLos datos recopilados se almacenan en la base de datos de Google encrptados de forma segura.\nLos unicos servicios de terceros involucrados son los de autenticación de Google.\n\nLos datos recopilados por estos servicios son:\n- Nombre de usuario\n- Email\n- Contraseña\n\nLos datos recopilados por estos servicios se utilizan para:\n- Autenticación de usuario\n\nNunca se compartirán los datos recopilados con terceros ni se utilizarán para otros fines.",
          "privacy_policy_security_title": "Seguridad",
          "privacy_policy_security_body":
              "Los datos recopilados se almacenan en la base de datos de Google encrptados de forma segura.",
          "privacy_policy_rights_title": "Derechos",
          "privacy_policy_rights_body":
              "Los usuarios de la aplicación tienen derecho a:\n- Acceder a sus datos personales\n- Rectificar sus datos personales\n- Eliminar sus datos personales\n- Limitar el procesamiento de sus datos personales\n- Oponerse al procesamiento de sus datos personales\n- Portar sus datos personales\n\nPara ejercer estos derechos, los usuarios pueden ponerse en contacto con el propietario del sitio web/app a través del correo electrónico.",
          "privacy_policy_updates_title": "Actualizaciones",
          "privacy_policy_updates_body":
              "Nos reservamos el derecho de efectuar sin previo aviso las modificaciones que consideremos oportunas en la web, pudiendo cambiar, suprimir o añadir tanto los contenidos y servicios que se presten a través de la misma como la forma en la que éstos aparezcan presentados.\nPor otro lado, podremos actualizar estos términos y condiciones. Las modificaciones entrarán en vigor desde el momento de su publicación.",
          "forgot_password_body":
              "No te preocupes, te ayudaremos a recuperarla.\nSolo tienes que introducir tu correo electrónico y te enviaremos un enlace para que puedas restablecer tu contraseña.",
          "delete_account": "Borrar cuenta",
          "delete_account_body":
              "¿Estás seguro de que quieres borrar tu cuenta?",
          "error_deleting_account":
              "Error al borrar la cuenta, para borrar la cuenta debes estar logueado previamente.",
          "delete_account_success": "Cuenta borrada correctamente",
          "minute_unit": "min",
          "pomodoro_session_unit": "sesión/es",
          "task_form_success_add_calendar_event":
              "Evento añadido al calendario del dispositivo correctamente",
          "task_form_error_calendar_event":
              "Error del evento al calendario del dispositivo",
          "task_form_success_remove_calendar_event":
              "Evento eliminado del calendario del dispositivo correctamente",
          "task_form_error_time":
              "La hora de la tarea no puede ser anterior a la hora actual",
          "task_form_input_end_date_title":
              "Fecha de finalización de la tarea (opcional)",
          "task_form_input_date_end": "Fecha de finalización de la tarea",
          "task_form_input_time_end": "Hora de finalización de la tarea",
          "edit_task": "Editar tarea",
          "edit_task_message":
              "¿Estás seguro de que quieres editar esta tarea?",
          "edit_task_submessage":
              "(Si quieres empezar la tarea pulsa en el play)",
        },
      };
}
