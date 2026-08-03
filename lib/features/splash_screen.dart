import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.red,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: AppScaffold(
        child: Center(
          child: Column(
            spacing: 32,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white10),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "PulseBoard is now live in Beta",
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "Manage your work at the Speed of Pulse.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 48,
                  color: Colors.white,
                  height: 1.15,
                ),
              ),
              Text(
                "The real-time project management tool built for modern teams. Sync instantly, collaborate seamlessly, and ship faster than ever before.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[400],
                  height: 1.15,
                ),
              ),
              AppButton(
                onPressed: () {
                  context.push(AppRoutes.signup);
                },
                textStyle: TextStyle(color: Colors.white, fontSize: 20),
                title: "Get Started for Free",
                backgroundColor: Color.fromARGB(255, 123, 118, 255),
              ),
              AppButton(
                onPressed: () {
                  print("Button");
                },
                textStyle: TextStyle(color: Colors.white, fontSize: 20),
                title: "Sign In",
                backgroundColor: Colors.transparent,
                borderSide: BorderSide(
                  color: Color.fromARGB(40, 250, 250, 250),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
