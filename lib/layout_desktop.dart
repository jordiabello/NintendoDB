import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'layout_personatge.dart';
import 'layout_consola.dart';
import 'layout_joc.dart';
import 'app_data.dart';


List<String> dropDownList = <String>['Personatges', 'Jocs', 'Consoles'];

class LayoutDesktop extends StatefulWidget {

const LayoutDesktop({super.key});

@override
State<LayoutDesktop> createState() => _StateLayoutDesktop();
}

class _StateLayoutDesktop extends State<LayoutDesktop> {
    String seccio = dropDownList.first; // El valor del desplegable
    int item = -1; // Element seleccionat, -1 si no n'hi ha cap

    _StateLayoutDesktop();

    Widget _dropDown() {
        return DropdownButton<String>(
            value: seccio,
            isExpanded: true,
            onChanged: (String? value) {
                setState(() {
                    seccio = value!;
                    item = -1;
                });
            },
            items: dropDownList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
        );
    }

    Widget _itemsList(AppData appData) {
        if (!appData.dataReady(seccio)) {
            // Si no tenim les dades, carregar-les i mostrar un 'loading'
            appData.load(seccio);
            return const Center(child: CircularProgressIndicator());
        } else {
            // Dades disponibles, construir automàticament la llista
            var data = appData.getData(seccio);
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text(data[index]['nom'], style: const TextStyle(fontSize: 12)),
                        leading: Image.asset(
                            'assets/images/${data[index]["imatge"]}',
                            height: 35.0, width: 35.0, fit: BoxFit.contain,
                        ),
                        onTap: () => {
                            setState(() => item = index)
                        }
                    );
                }
            );
        }
    }

    Widget _sideBar(AppData appData) {
        return Container(
            width: 200.0,
            height: MediaQuery.of(context).size.height,
            color: const Color.fromARGB(255, 239, 245, 248),
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
                children: [
                    _dropDown(),
                    Expanded(child: _itemsList(appData)),
                ],
            ),
        );
    }

    Widget _content(AppData appData) {
        if (item != -1) {
            dynamic itemData = appData.getItemData(seccio, item);
            switch (seccio) {
                case 'Personatges': return LayoutPersonatge(itemData: itemData);
                case 'Consoles': return LayoutConsola(itemData: itemData);
                case 'Jocs': return LayoutJoc(itemData: itemData);
            }
        }
        return const Text("");
    }


    @override
    Widget build(BuildContext context) {
        AppData appData = Provider.of<AppData>(context);
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('Nintendo DB'),
            ),
            body: Row(
                  children: <Widget>[
                        _sideBar(appData),
                        Expanded(child: _content(appData))
                  ],
            )
        );
    }
}
