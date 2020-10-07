part of "widgets.dart";

class BrowseButton extends StatelessWidget {
  final String genre;

  BrowseButton(this.genre);
  @override
  Widget build(BuildContext context) {
    // WIDGET: ICON
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFEEF1F8),
          ),
          child: Center(
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: (genre == "Horor")
                      ? AssetImage("assets/ic_horor.png")
                      : (genre == "Action")
                          ? AssetImage("assets/ic_action.png")
                          : (genre == "Music")
                              ? AssetImage("assets/ic_music.png")
                              : (genre == "War")
                                  ? AssetImage("assets/ic_war.png")
                                  : (genre == "Drama")
                                      ? AssetImage("assets/ic_drama.png")
                                      : AssetImage("assets/ic_crime.png"),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        // WIDGET: Title
        Text(
          genre,
          style: blackTextFont.copyWith(fontSize: 12),
        )
      ],
    );
  }
}
