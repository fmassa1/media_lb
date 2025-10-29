import 'package:flutter/material.dart';
import '../../data/models/crew.dart';

class CrewList extends StatelessWidget {
  final List<Crew> crewMembers;
  final String category;

  const CrewList({super.key, required this.crewMembers, required this.category});

  @override
  Widget build(BuildContext context) {
    if (crewMembers.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          category,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200, // poster + title height
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: crewMembers.length,
            itemBuilder: (context, index) {
              final member = crewMembers[index];
              return GestureDetector(

                //TODO navigate to crew members page

                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (_) => MovieDetailScreen(movie: member),
                //     ),
                //   );
                // },
                child: Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: member.imagePath != null
                              ? Image.network(
                            'https://image.tmdb.org/t/p/w200${member.imagePath}',
                            height: 160,
                            fit: BoxFit.cover,
                          )
                              : Image.asset(
                            'lib/assets/person_placeholder.png',
                            height: 160,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        member.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        member.job ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
