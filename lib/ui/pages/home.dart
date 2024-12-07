// 스크롤 넣기, 사진 넣기, 게시글 클릭
import 'package:flutter/material.dart';
import 'profile.dart'; // 코드 B의 Profile 페이지 import

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({Key? key, required this.token}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // BottomNavigationBar의 현재 인덱스
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WePets'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // 로그아웃 기능 구현
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 4) {
            // MY 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(token: widget.token),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: '내주변'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: '커뮤니티'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'MY'),
        ],
      ),
    );
  }

  // 바디 콘텐츠
  Widget _buildBody() {
    switch (_currentIndex) {
      case 0: // 홈
        return _buildHomePage();
      case 1: // 검색
        return _buildSearchPage();
      case 2: // 내 주변
        return const Center(child: Text('내 주변 페이지'));
      case 3: // 커뮤니티
        return const Center(child: Text('커뮤니티 페이지'));
      default:
        return const Center(child: Text('페이지 없음'));
    }
  }

  // 홈 페이지 콘텐츠
  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 검색바
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '검색',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onSubmitted: (query) {
                // 검색 기능 구현
                print('검색어: $query');
              },
            ),
          ),
          // 베스트 게시글
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'BEST 게시글',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 200, // 슬라이더 높이
            child: PageView(
              children: List.generate(
                5,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      'BEST 게시글 ${index + 1}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 일반 게시글 리스트
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '일반 게시글',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true, // 스크롤뷰 안에서 스크롤 문제 방지
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10, // 임시 데이터 개수
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text('일반 게시글 ${index + 1}'),
              );
            },
          ),
        ],
      ),
    );
  }

  // 검색 페이지 콘텐츠
  Widget _buildSearchPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: '검색어를 입력하세요',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onSubmitted: (query) {
              // 검색 로직 구현
              print('검색어: $query');
            },
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              '검색 결과를 여기에 표시합니다.\n검색어: ${_searchController.text}',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
