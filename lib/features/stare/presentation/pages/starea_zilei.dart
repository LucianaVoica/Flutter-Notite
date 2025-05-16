import 'package:flutter/material.dart';

class StareaZilei extends StatelessWidget {
  const StareaZilei({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        color: Theme.of(context).colorScheme.secondaryFixed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Starea zilei',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('😊 Astăzi te simți bine!'),
            ],
          ),
        ),
      ),
    );
  }
}
