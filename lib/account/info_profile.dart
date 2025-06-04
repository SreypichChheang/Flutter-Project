import 'package:flutter/material.dart';

class InformationScreen extends StatefulWidget {
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _allQuestions = [
    {
      'question': 'What is smart home automation, and how does it work?',
      'answer': 'Smart home automation is a system that allows you to control and monitor your home devices remotely using internet connectivity. It works by connecting various devices like lights, thermostats, security cameras, and appliances to a central hub or network, which can be controlled through smartphones, tablets, or voice commands.'
    },
    {
      'question': 'What are the benefits of a smart home system?',
      'answer': 'Smart home systems offer numerous benefits including: energy efficiency and cost savings, enhanced security and monitoring, convenience and remote control, increased property value, customizable automation routines, and improved accessibility for elderly or disabled residents.'
    },
    {
      'question': 'Which devices can be controlled in a smart home?',
      'answer': 'You can control a wide variety of devices including: lighting systems, thermostats and HVAC, security cameras and door locks, smart speakers and entertainment systems, kitchen appliances, garage doors, irrigation systems, smoke detectors, and window blinds or curtains.'
    },
    {
      'question': 'How secure are smart home devices?',
      'answer': 'Smart home device security varies by manufacturer and implementation. To enhance security: use strong, unique passwords, enable two-factor authentication, keep firmware updated, use encrypted communication protocols, set up a separate network for smart devices, and regularly review device permissions and access logs.'
    },
    {
      'question': 'What internet speed do I need for smart home devices?',
      'answer': 'Most smart home devices require minimal bandwidth. A basic broadband connection (25 Mbps) is sufficient for most setups. However, for multiple high-definition security cameras or streaming devices, you may need higher speeds (50-100 Mbps) for optimal performance.'
    },
    {
      'question': 'Can smart home devices work without internet?',
      'answer': 'Some smart home devices can function locally without internet connectivity, especially those using protocols like Zigbee or Z-Wave with local hubs. However, remote access, cloud features, voice assistants, and software updates typically require an internet connection.'
    },
    {
      'question': 'How do I start building a smart home system?',
      'answer': 'Start small with: 1) Choose a central hub or platform, 2) Begin with basic devices like smart bulbs or plugs, 3) Add a smart thermostat for energy savings, 4) Include security devices like smart locks or cameras, 5) Gradually expand based on your needs and budget, 6) Ensure device compatibility before purchasing.'
    },
    {
      'question': 'What is the cost of implementing a smart home system?',
      'answer': 'Costs vary widely depending on the scope: Basic starter kit: \$200-500, Mid-range system: \$1,000-3,000, Comprehensive system: \$5,000-15,000+. Consider starting with essential devices and expanding gradually to spread costs over time.'
    }
  ];
  
  List<Map<String, String>> _filteredQuestions = [];

  @override
  void initState() {
    super.initState();
    _filteredQuestions = _allQuestions;
  }

  void _filterQuestions(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredQuestions = _allQuestions;
      } else {
        _filteredQuestions = _allQuestions.where((item) =>
          item['question']!.toLowerCase().contains(query.toLowerCase()) ||
          item['answer']!.toLowerCase().contains(query.toLowerCase())
        ).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Information',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.help_outline, color: Colors.white),
              onPressed: () {
                _showHelpDialog();
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterQuestions,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  hintText: 'Ask Question',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                  suffixIcon: Icon(
                    Icons.mic,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 24),
            
            // Top Questions Header
            Text(
              'Top Question',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            
            SizedBox(height: 16),
            
            // Questions List
            Expanded(
              child: _filteredQuestions.isEmpty
                  ? _buildNoResultsWidget()
                  : ListView.builder(
                      itemCount: _filteredQuestions.length,
                      itemBuilder: (context, index) {
                        return _buildQuestionItem(_filteredQuestions[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionItem(Map<String, String> item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          _showAnswerDialog(item['question']!, item['answer']!);
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  item['question']!,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoResultsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'No questions found',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _showAnswerDialog(String question, String answer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Answer',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  question,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  answer,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Got it',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.help_outline, color: Colors.blue),
              SizedBox(width: 8),
              Text('Help'),
            ],
          ),
          content: Text(
            'Here you can find answers to frequently asked questions about smart home automation. Use the search bar to find specific topics or browse through the top questions.',
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}