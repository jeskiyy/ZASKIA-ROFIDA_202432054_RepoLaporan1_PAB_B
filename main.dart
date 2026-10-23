
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// MODEL DATA LAGU
class Song {
  final String title;
  final String artist;

  const Song(this.title, this.artist);
}

// MODEL DATA MOOD
class Mood {
  final String name;
  final String emoji;
  final Color color;
  final List<Song> songs;

  const Mood(this.name, this.emoji, this.color, this.songs);
}

// MODEL DATA PENGGUNA
class UserProfile {
  final String nim;
  final String name;
  final int semester;
  final bool isStudent;

  const UserProfile({
    required this.nim,
    required this.name,
    required this.semester,
    required this.isStudent,
  });
}

const userProfile = UserProfile(
  nim: '202432054',
  name: 'Zaskia Rofida',
  semester: 5,
  isStudent: true,
);

// DATA LAGU
const moods = [
  Mood('Happy', '☀️', Color(0xFFFFC857), [
    Song('drop dead', 'Olivia Rodrigo'),
    Song('Sunday Best', 'Surfaces'),
    Song('Lover', 'Taylor Swift'),
  ]),
  Mood('Sad', '🌧️', Color(0xFF90CAF9), [
    Song('La La La Lost You', 'NIKI'),
    Song("Why Can't I", 'Nathaniel Constantin'),
    Song('Cause You Have To', 'LANY'),
  ]),
  Mood('Chill', '☁️', Color(0xFF80CBC4), [
    Song('Bertaut', 'Nadin Amizah'),
    Song('Rehat', 'Kunto Aji'),
    Song('Best Part', 'Daniel Caesar ft. H.E.R.'),
  ]),
  Mood('Love', '💗', Color(0xFFF48FB1), [
    Song('Akad', 'Payung Teduh'),
    Song('Glue Song', 'beabadoobee'),
    Song('Nothing', 'Bruno Major'),
  ]),
  Mood('Angry', '🔥', Color(0xFFEF9A9A), [
    Song('good 4 u', 'Olivia Rodrigo'),
    Song('The Man', 'Taylor Swift'),
    Song('abcdefu', 'GAYLE'),
  ]),
];

// ROOT APPLICATION
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moodie with a Song',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF7FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE78BA7),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFF7FA),
          foregroundColor: Color(0xFF553B46),
        ),
      ),
      home: const MoodiePage(),
    );
  }
}

// HALAMAN UTAMA
class MoodiePage extends StatefulWidget {
  const MoodiePage({super.key});

  @override
  State<MoodiePage> createState() => _MoodiePageState();
}

class _MoodiePageState extends State<MoodiePage> {
  Mood selectedMood = moods[0];
  late Song selectedSong = selectedMood.songs[0];

  void chooseMood(Mood mood) {
    setState(() {
      selectedMood = mood;
      selectedSong = mood.songs[0];
    });
  }

  void chooseSong(Song song) {
    setState(() => selectedSong = song);
  }

  void saveMood() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Mood ${selectedMood.name} berhasil disimpan! 💗',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'moodie.',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.favorite,
              color: Color(0xFFE78BA7),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double pagePadding =
                constraints.maxWidth < 400 ? 16.0 : 24.0;

            return SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 650),
                  child: Padding(
                    padding: EdgeInsets.all(pagePadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // WELCOME SECTION
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE0EA),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'a little music,\na little mood. 🎧',
                                style: TextStyle(
                                  fontSize: 27,
                                  height: 1.3,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF704454),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text('How are you feeling today?'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // STUDENT PROFILE
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Color(0xFFFFE0EA),
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Color(0xFFB85C7A),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userProfile.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF553B46),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text('NIM: ${userProfile.nim}'),
                                      Text(
                                        'Semester ${userProfile.semester}',
                                      ),
                                      Text(
                                        userProfile.isStudent
                                            ? 'Mahasiswa Aktif'
                                            : 'Bukan Mahasiswa',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),

                        // MOOD SELECTION
                        const SectionTitle(
                          title: 'Choose your mood',
                          subtitle: 'Pick the feeling that matches your day.',
                        ),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: moods.map((mood) {
                            return ChoiceChip(
                              label: Text('${mood.emoji} ${mood.name}'),
                              selected: selectedMood.name == mood.name,
                              selectedColor: mood.color,
                              onSelected: (_) => chooseMood(mood),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 26),

                        // SONG LIST
                        const SectionTitle(
                          title: 'Songs for you',
                          subtitle: 'A playlist for your current mood.',
                        ),
                        const SizedBox(height: 14),
                        ...selectedMood.songs.asMap().entries.map((entry) {
                          final song = entry.value;
                          final bool isSelected =
                              selectedSong.title == song.title;

                          return SongCard(
                            song: song,
                            number: entry.key + 1,
                            selected: isSelected,
                            color: selectedMood.color,
                            onTap: () => chooseSong(song),
                          );
                        }),
                        const SizedBox(height: 16),

                        // SELECTED SONG PREVIEW
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: selectedMood.color
                                    .withValues(alpha: 0.5),
                                child: const Icon(Icons.music_note),
                              ),
                              title: const Text(
                                'YOUR PICK',
                                style: TextStyle(
                                  fontSize: 11,
                                  letterSpacing: 1,
                                  color: Color(0xFFB85C7A),
                                ),
                              ),
                              subtitle: Text(
                                '${selectedSong.title}\n'
                                '${selectedSong.artist}',
                              ),
                              trailing: const Icon(
                                Icons.favorite,
                                color: Color(0xFFE78BA7),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // SAVE BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: saveMood,
                            icon: const Icon(Icons.bookmark),
                            label: const Text('Save My Mood'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE78BA7),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // WATERMARK
                        Center(
                          child: Text(
                            '${userProfile.nim}_${userProfile.name.replaceAll(' ', '')}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFFB99AA5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// CUSTOM WIDGET: SECTION TITLE
class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Color(0xFF553B46),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF957782),
          ),
        ),
      ],
    );
  }
}

// CUSTOM WIDGET: SONG CARD
class SongCard extends StatelessWidget {
  final Song song;
  final int number;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const SongCard({
    super.key,
    required this.song,
    required this.number,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 2,
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.5),
              child: Text(
                number.toString().padLeft(2, '0'),
                style: const TextStyle(fontSize: 12),
              ),
            ),
            title: Text(
              song.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(song.artist),
            trailing: Icon(
              selected
                  ? Icons.check_circle
                  : Icons.play_circle_outline,
              color: const Color(0xFFB85C7A),
            ),
          ),
        ),
      ),
    );
  }
}
