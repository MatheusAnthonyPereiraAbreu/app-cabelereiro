import 'package:flutter/material.dart';
import 'package:appcabelereiro/pages/select_service.dart';
import 'package:appcabelereiro/pages/profile.dart';
import 'package:appcabelereiro/components/appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cabeleireiro App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: TextTheme(
          headline6: TextStyle(
            // fontFamily: 'Barlow Condensed',
            fontWeight: FontWeight.w700,
            fontSize: 50.0,
            color: Colors.white,
          ),
          bodyText2: TextStyle(
            // fontFamily: 'Barlow Condensed',
            fontWeight: FontWeight.w300,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Permitir que a imagem se estenda atrás do AppBar
      appBar: CustomAppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Agendar Horário'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServicoPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PerfilPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/fundo.jpg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: AppBar().preferredSize.height),
                            child: Icon(
                              Icons.spa,
                              size: 150,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            'Bem Vindo ao Hozan!',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Tradicional e moderno, oferecemos serviços de beleza personalizados com mais de 20 anos de excelência. Nossa equipe talentosa e ambiente acolhedor garantem uma experiência única de cuidados capilares. Descubra sua verdadeira beleza no Cabeleireiro Hozan.',
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Icon(
                            Icons.arrow_downward,
                            size: 50,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ServiceCard(
                          icon: Icons.straighten,
                          title: 'Corte',
                          description: 'Corte moderno e estilizado.'),
                      ServiceCard(
                          icon: Icons.color_lens,
                          title: 'Coloração',
                          description:
                              'Coloração personalizada para realçar sua beleza.'),
                      ServiceCard(
                          icon: Icons.accessibility_new,
                          title: 'Penteado',
                          description: 'Penteados elegantes e exclusivos.'),
                      ServiceCard(
                          icon: Icons.local_mall,
                          title: 'Produtos',
                          description:
                              'Produtos de alta qualidade para cuidados em casa.'),
                      ServiceCard(
                          icon: Icons.face,
                          title: 'Estilo',
                          description:
                              'Estilo único para refletir sua personalidade.'),
                      ServiceCard(
                          icon: Icons.category,
                          title: 'Mais',
                          description:
                              'Outros serviços para atender às suas necessidades.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const ServiceCard(
      {Key? key,
      required this.icon,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(
          20.0), // Aumenta o padding para tornar o retângulo maior
      decoration: BoxDecoration(
        color: Colors.black,
        // Remove a propriedade borderRadius para eliminar as bordas arredondadas
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment
            .center, // Centraliza verticalmente os widgets na Row
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.white,
          ),
          VerticalDivider(
            color: Colors.grey,
            thickness: 1.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Centraliza verticalmente os widgets na Column
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
