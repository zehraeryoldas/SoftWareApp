import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:softwareapp_firebase/models/profile.dart';
import 'package:softwareapp_firebase/viewmodel/contacts_model.dart';
import 'package:softwareapp_firebase/viewmodel/sign_in_model.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişiler"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: ContactSearchDelegate());
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ContactList(
        query: '',
      ),
    );
  }
}

class ContactList extends StatelessWidget {
  final String query;
  const ContactList({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = GetIt.instance<ContactsModel>();
    var user = Provider.of<signInModel>(context).currentUser;

    return FutureBuilder(
        future: model.getContacts(query),
        builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text(snapshot.error.toString()),
            );

          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return ListView(
              children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.group,
                  color: Colors.white,
                ),
              ),
              title: Text("New Group"),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
              ),
              title: Text("New Contact"),
              onTap: () {},
            ),
          ]..addAll(snapshot.data!
                  .map(
                    (profile) => ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        backgroundImage: NetworkImage(profile.image),
                      ),
                      title: Text(profile.userName),
                      //listeledğimiz kişileri listeye ekleyen on tap parametresini closurunda bir işlem yapalım
                      onTap: () async =>
                          model.startConversation(user!, profile),
                    ),
                  )
                  .toList()));
        });
  }
}

class ContactSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      primaryColor: theme.primaryColor,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      }, //butona basıldığında search delegatı kapatmamaız lazım
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return ContactList(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Center(
      child: Text(
        "Sohbet başlatmak için ara",
      ),
    );
  }
}
