import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_challenge/screens/cubits/theme_cubit.dart';
import 'package:web_challenge/screens/cubits/update_profile_cubit.dart';
import 'package:web_challenge/theme/text_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _selectedCategory;
  bool _obscurePassword = true;

  final List<String> categories = [
    "Nature",
    "Technology",
    "Sports",
    "Art",
    "Travel",
    "Food",
  ];

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.tealAccent),
      filled: true,
      fillColor: Colors.grey[900],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.tealAccent, width: 2),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final profileData = {
      "name": _nameController.text,
      "email": _emailController.text,
      "favoriteCategory": _selectedCategory,
      "password": _passwordController.text,
    };

    context.read<ProfileCubit>().submitProfile(profileData);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDark = themeMode == ThemeMode.dark;
        final backgroundColor = isDark ? Colors.black : Colors.white;
        final cardColor = isDark ? Colors.grey[850] : Colors.grey[200];
        final textColor = isDark ? Colors.white70 : Colors.black87;
        final hintColor = isDark ? Colors.white60 : Colors.black45;

        InputDecoration _inputDecoration(String label, IconData icon) {
          return InputDecoration(
            labelText: label,
            labelStyle: AppTextStyles.body.copyWith(color: hintColor),
            prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            filled: true,
            fillColor: cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.black26,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.black26,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            title: const Text(""),
            elevation: 0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: BlocConsumer<ProfileCubit, ProfileState>(
                    listener: (context, state) {
                      if (state is ProfileSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: cardColor,
                            behavior: SnackBarBehavior.floating,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            content: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.tealAccent,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "Profile saved! Returned ID: ${state.id}",
                                    style: AppTextStyles.body.copyWith(
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (state is ProfileError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("⚠️ Error: ${state.error}"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      final isSubmitting = state is ProfileLoading;

                      return Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Text(
                                "Profile Page",
                                style: AppTextStyles.pageTitle.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(height: 30),

                              // Name
                              TextFormField(
                                controller: _nameController,
                                style: AppTextStyles.input.copyWith(
                                  color: textColor,
                                ),
                                decoration: _inputDecoration(
                                  "Full Name",
                                  Icons.person,
                                ),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? "Enter full name"
                                    : null,
                              ),
                              const SizedBox(height: 20),

                              // Email
                              TextFormField(
                                controller: _emailController,
                                style: AppTextStyles.input.copyWith(
                                  color: textColor,
                                ),
                                decoration: _inputDecoration(
                                  "Email",
                                  Icons.email,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return "Enter email";
                                  if (!RegExp(
                                    r"^[^@]+@[^@]+\.[^@]+",
                                  ).hasMatch(value)) {
                                    return "Enter valid email";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              // Dropdown
                              DropdownButtonFormField<String>(
                                dropdownColor: cardColor,
                                value: _selectedCategory,
                                decoration: _inputDecoration(
                                  "Favorite Category",
                                  Icons.category_outlined,
                                ),
                                items: categories.map((c) {
                                  return DropdownMenuItem(
                                    value: c,
                                    child: Text(
                                      c,
                                      style: AppTextStyles.body.copyWith(
                                        color: textColor,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) =>
                                    setState(() => _selectedCategory = val),
                                validator: (value) =>
                                    value == null ? "Select a category" : null,
                              ),
                              const SizedBox(height: 20),

                              // Password
                              TextFormField(
                                controller: _passwordController,
                                style: AppTextStyles.input.copyWith(
                                  color: textColor,
                                ),
                                obscureText: _obscurePassword,
                                decoration:
                                    _inputDecoration(
                                      "Password",
                                      Icons.lock,
                                    ).copyWith(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () => setState(
                                          () => _obscurePassword =
                                              !_obscurePassword,
                                        ),
                                      ),
                                    ),
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return "Enter password";
                                  if (value.length < 6)
                                    return "Password must be at least 6 chars";
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              // Confirm Password
                              TextFormField(
                                controller: _confirmPasswordController,
                                style: AppTextStyles.input.copyWith(
                                  color: textColor,
                                ),
                                obscureText: true,
                                decoration: _inputDecoration(
                                  "Confirm Password",
                                  Icons.lock,
                                ),
                                validator: (value) =>
                                    value != _passwordController.text
                                    ? "Passwords do not match"
                                    : null,
                              ),
                              const SizedBox(height: 28),

                              // Button
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Colors.tealAccent,
                                        Colors.lightBlueAccent,
                                      ],
                                    ),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: isSubmitting
                                        ? null
                                        : () => _submitForm(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: isSubmitting
                                        ? SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: CircularProgressIndicator(
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          )
                                        : Text(
                                            "Save Profile",
                                            style: AppTextStyles.button,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
