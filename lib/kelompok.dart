import 'package:flutter/material.dart';

class KelompokPage extends StatelessWidget {
  const KelompokPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelompok 42 PPB'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ivan Danisworo Abadi (21120120130059'),
            Divider(),
            Text('Hibatullah Dyfa Grahatama (21120120130058'),
            Divider(),
            Text('Adid Hardiansyah (21120120120026)'),
            Divider(),
            Text('Rizal Agatha Erdin Agesyah (21120120120010)'),],
        ),
      )
    );
  }
}