import 'package:flutter/material.dart';

class CardMaterialWidget extends StatelessWidget {
  String title;
  String subtitle;
  String description;
  String imageUrl;

  CardMaterialWidget(this.title, this.subtitle, this.description, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/poste-de-barbeiro.png'),
            ),
            title: Text(title),
            subtitle: Text(
              subtitle,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Image.network(
            imageUrl,
            width: MediaQuery.of(context).size.width,
            height: 200,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              description,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
              maxLines: 5,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
