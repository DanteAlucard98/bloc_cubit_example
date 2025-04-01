import 'package:bloc_cubits_test/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:bloc_cubits_test/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo usuario')),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlutterLogo(size: 100),

              _RegisterForm(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre de usuario',
            onChanged: (value) {
              registerCubit.usernameChanged(value);
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El nombre de usuario es requerido';
              }
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 6) {
                return 'El nombre de usuario debe tener al menos 6 caracteres';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Correo electrónico',
            onChanged: (value) {
              registerCubit.emailChanged(value);
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El correo electrónico es requerido';
              }
              if (value.trim().isEmpty) return 'Campo requerido';
              final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegExp.hasMatch(value)) {
                return 'Correo electrónico inválido';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: (value) {
              registerCubit.passwordChanged(value);
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'La contraseña es requerido';
              }
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          FilledButton.tonalIcon(
            onPressed: () {
              final isValid = _formKey.currentState?.validate();
              if (!isValid!) return;
              registerCubit.onSubmit();
            },
            icon: const Icon(Icons.save),
            label: const Text('Crear usuario'),
          ),
        ],
      ),
    );
  }
}
