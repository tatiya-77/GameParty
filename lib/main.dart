import 'package:flutter/material.dart';

void main() {
  runApp(const GamePartyApp());
}

class GamePartyApp extends StatelessWidget {
  const GamePartyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Party',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF7F5FB),
      ),
      home: const GamePartyHome(),
    );
  }
}

class PartyPost {
  PartyPost({
    required this.user,
    required this.game,
    required this.title,
    required this.detail,
    this.likes = 0,
    this.comments = 0,
  });

  String user;
  String game;
  String title;
  String detail;
  int likes;
  int comments;
  bool liked = false;
}

class GamePartyHome extends StatefulWidget {
  const GamePartyHome({super.key});

  @override
  State<GamePartyHome> createState() => _GamePartyHomeState();
}

class _GamePartyHomeState extends State<GamePartyHome> {
  int _index = 0;
  final TextEditingController _search = TextEditingController();

  final List<PartyPost> _posts = [
    PartyPost(
      user: 'Mint',
      game: 'Valorant',
      title: 'หาเพื่อนลงแรงค์ 2 คน',
      detail: 'เล่นประมาณ 20:00 น. ขอคนคุยง่าย ๆ เน้นสนุกครับ',
      likes: 12,
      comments: 4,
    ),
    PartyPost(
      user: 'Boss',
      game: 'ROV',
      title: 'หาตี้ 5 คน ลงแรงค์',
      detail: 'ขาดตำแหน่งฟาร์มกับเมจ เล่นยาวถึงประมาณเที่ยงคืน',
      likes: 8,
      comments: 2,
    ),
    PartyPost(
      user: 'Tatiy',
      game: 'Minecraft',
      title: 'หาเพื่อนสร้าง Survival World',
      detail: 'เริ่มเซิร์ฟใหม่ เล่นชิล ๆ ช่วยกันสร้างบ้านและฟาร์ม',
      likes: 15,
      comments: 6,
    ),
  ];

  final List<String> _groups = [
    'Valorant Thailand',
    'ROV หาตี้แรงค์',
    'Minecraft Survival',
  ];

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _addPost() {
    final title = TextEditingController();
    final detail = TextEditingController();
    String game = 'Valorant';

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('สร้างโพสต์หาตี้'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: game,
                  decoration: const InputDecoration(labelText: 'เกม'),
                  items: const ['Valorant', 'ROV', 'Minecraft', 'PUBG', 'อื่น ๆ']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setDialogState(() => game = v!),
                ),
                TextField(
                  controller: title,
                  decoration: const InputDecoration(labelText: 'หัวข้อ'),
                ),
                TextField(
                  controller: detail,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'รายละเอียด'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ยกเลิก'),
            ),
            FilledButton(
              onPressed: () {
                if (title.text.trim().isEmpty) return;
                setState(() {
                  _posts.insert(
                    0,
                    PartyPost(
                      user: 'Tatiy',
                      game: game,
                      title: title.text.trim(),
                      detail: detail.text.trim(),
                    ),
                  );
                });
                Navigator.pop(context);
              },
              child: const Text('โพสต์'),
            ),
          ],
        ),
      ),
    );
  }

  void _showComments(PartyPost post) {
    final comment = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ความคิดเห็น (${post.comments})',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            const ListTile(
              leading: CircleAvatar(child: Text('M')),
              title: Text('Mint'),
              subtitle: Text('ยังหาคนเพิ่มได้ไหมครับ?'),
            ),
            const ListTile(
              leading: CircleAvatar(child: Text('B')),
              title: Text('Boss'),
              subtitle: Text('ขอเข้าตี้ด้วยครับ'),
            ),
            TextField(
              controller: comment,
              decoration: InputDecoration(
                hintText: 'เขียนความคิดเห็น...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (comment.text.trim().isNotEmpty) {
                      setState(() => post.comments++);
                      comment.clear();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _feedPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Party'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
          IconButton(
            onPressed: () => _showProfile(),
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addPost,
        icon: const Icon(Icons.add),
        label: const Text('หาตี้'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _search,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'ค้นหาเกม / โพสต์ / ผู้เล่น',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _search.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _search.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear),
                      ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
              children: [
                _sectionTitle('โพสต์หาตี้ล่าสุด'),
                ..._posts
                    .where((p) =>
                        _search.text.isEmpty ||
                        '${p.game} ${p.title} ${p.detail} ${p.user}'
                            .toLowerCase()
                            .contains(_search.text.toLowerCase()))
                    .map(_postCard),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _postCard(PartyPost post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(post.user.substring(0, 1).toUpperCase()),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(post.user,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                Chip(label: Text(post.game)),
                PopupMenuButton<String>(
                  onSelected: (v) {
                    if (v == 'delete') {
                      setState(() => _posts.remove(post));
                    }
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'report', child: Text('รายงานโพสต์')),
                    PopupMenuItem(value: 'delete', child: Text('ลบโพสต์')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(post.title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(post.detail),
            const Divider(height: 24),
            Row(
              children: [
                IconButton(
                  onPressed: () => setState(() {
                    post.liked = !post.liked;
                    post.likes += post.liked ? 1 : -1;
                  }),
                  icon: Icon(post.liked
                      ? Icons.favorite
                      : Icons.favorite_border),
                  color: post.liked ? Colors.red : null,
                ),
                Text('${post.likes}'),
                IconButton(
                  onPressed: () => _showComments(post),
                  icon: const Icon(Icons.mode_comment_outlined),
                ),
                Text('${post.comments}'),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () => _showJoinDialog(post),
                  icon: const Icon(Icons.group_add_outlined),
                  label: const Text('เข้าตี้'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showJoinDialog(PartyPost post) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('เข้าร่วมตี้ ${post.game}'),
        content: Text('ต้องการส่งคำขอเข้าร่วมตี้ของ ${post.user} หรือไม่?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ยกเลิก')),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ส่งคำขอเข้าร่วมตี้แล้ว')),
              );
            },
            child: const Text('ส่งคำขอ'),
          ),
        ],
      ),
    );
  }

  Widget _groupsPage() {
    return Scaffold(
      appBar: AppBar(title: const Text('กลุ่ม / เพจ')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton.icon(
            onPressed: () => _createGroup(),
            icon: const Icon(Icons.add),
            label: const Text('สร้างกลุ่ม'),
          ),
          const SizedBox(height: 12),
          ..._groups.map(
            (g) => Card(
              elevation: 0,
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.groups)),
                title: Text(g),
                subtitle: const Text('กลุ่มสำหรับหาเพื่อนเล่นเกม'),
                trailing: PopupMenuButton<String>(
                  onSelected: (v) {
                    if (v == 'leave') {
                      setState(() => _groups.remove(g));
                    }
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'leave', child: Text('ออกจากกลุ่ม')),
                  ],
                ),
                onTap: () => _showGroup(g),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _createGroup() {
    final name = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('สร้างกลุ่ม'),
        content: TextField(
          controller: name,
          decoration: const InputDecoration(hintText: 'ชื่อกลุ่ม'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ยกเลิก')),
          FilledButton(
            onPressed: () {
              if (name.text.trim().isNotEmpty) {
                setState(() => _groups.add(name.text.trim()));
                Navigator.pop(context);
              }
            },
            child: const Text('สร้าง'),
          ),
        ],
      ),
    );
  }

  void _showGroup(String group) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(group,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('โพสต์ล่าสุดในกลุ่ม'),
              const ListTile(
                leading: CircleAvatar(child: Text('T')),
                title: Text('หาเพื่อนเล่นคืนนี้'),
                subtitle: Text('Valorant • 20:00 น.'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('เข้าร่วมกลุ่ม'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatPage() {
    final chats = [
      ('Mint', 'คืนนี้ Valorant ไหม?'),
      ('Boss', 'เข้าตี้ ROV ได้เลย'),
      ('GameBoy', 'Minecraft world พร้อมแล้ว'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('ข้อความ')),
      body: ListView(
        children: chats
            .map(
              (c) => ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(c.$1),
                subtitle: Text(c.$2),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _openChat(c.$1),
              ),
            )
            .toList(),
      ),
    );
  }

  void _openChat(String user) {
    final controller = TextEditingController();
    final messages = <String>['สวัสดีครับ', 'สนใจเข้าตี้เกมไหม?'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .72,
            child: Column(
              children: [
                AppBar(title: Text(user), automaticallyImplyLeading: false),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: messages
                        .map((m) => Align(
                              alignment: Alignment.centerLeft,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(m),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration:
                              const InputDecoration(hintText: 'พิมพ์ข้อความ'),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (controller.text.trim().isEmpty) return;
                          setSheetState(() {
                            messages.add(controller.text.trim());
                            controller.clear();
                          });
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profilePage() {
    return Scaffold(
      appBar: AppBar(title: const Text('โปรไฟล์')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 48,
            child: Icon(Icons.person, size: 48),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text('Tatiy',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          const Center(child: Text('ผู้เล่นเกมสายชิล • 128 followers')),
          const SizedBox(height: 20),
          Card(
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('แก้ไขโปรไฟล์'),
                  onTap: _showProfile,
                ),
                const ListTile(
                  leading: Icon(Icons.public),
                  title: Text('โปรไฟล์สาธารณะ'),
                ),
                const ListTile(
                  leading: Icon(Icons.people_outline),
                  title: Text('ผู้ติดตาม / กำลังติดตาม'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showProfile() {
    final name = TextEditingController(text: 'Tatiy');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('แก้ไขโปรไฟล์'),
        content: TextField(
          controller: name,
          decoration: const InputDecoration(labelText: 'ชื่อผู้ใช้'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ยกเลิก')),
          FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('บันทึก')),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      );

  Widget _currentPage() {
    switch (_index) {
      case 0:
        return _feedPage();
      case 1:
        return _groupsPage();
      case 2:
        return _chatPage();
      default:
        return _profilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPage(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'หน้าหลัก'),
          NavigationDestination(
              icon: Icon(Icons.groups_outlined),
              selectedIcon: Icon(Icons.groups),
              label: 'กลุ่ม'),
          NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline),
              selectedIcon: Icon(Icons.chat_bubble),
              label: 'ข้อความ'),
          NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'โปรไฟล์'),
        ],
      ),
    );
  }
}
