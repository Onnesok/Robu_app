import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
class Project {
  final String title;
  final String description;
  final String imagePath;

  Project({required this.title, required this.description, required this.imagePath});
}


List<Project> projects = [
  Project(
    title: 'Bracu Onnesa',
    description: "BRAC Onnesha was the first nanosatellite built in Bangladesh to be launched into space. "
        "The satellite was designed and built in conjunction with Kyushu Institute of Technology Birds-1 program,"
        " which has the goal of helping countries build their first satellite. It was designed and built over a two-year period."
        " The satellite had imaging capabilities and could transmit songs to Earth that were uploaded to its memory. "
        "It was launched on a Falcon 9 rocket to the International Space Station on 3 June 2017, "
        "after which it was released from the Kibō module. The satellite completed an orbit once every 92 minutes."
        " The satellite deorbited on 6 May 2019.",
    imagePath: 'assets/projects/onnesa.jpg',
  ),
  Project(
    title: 'Bracu Mongoltori',
    description: "We are the BRACU Mongol Tori Mars Rover Team, a dynamic group of 40 dedicated undergraduate students united by our shared passion for engineering and technology. With unwavering enthusiasm, we collaborate to push the boundaries of innovation and contribute to the advancement of space exploration. "
        "Divided into nine specialized subteams, we collectively focus on various sectors of Rover development, each contributing a unique skill set to our common goal. Our mission is clear: to design and build an advanced Rover capable of serving multiple critical purposes, such as exploration, search and rescue, research, autonomous navigation, and executing "
        "challenging missions on the Martian terrain. At the heart of our efforts stands our respected faculty advisor, Dr. Md. Khalilur Rahman. As a Professor in the Department of Computer Science and Engineering at BRAC University, Dr. Md. Khalilur Rahman sir lends his expertise and guidance, enriching our learning experience and propelling our Rover development journey forward. "
        "Since our inception in 2017, the BRACU Mongol Tori team has been actively participating in various competitions, steadily building a legacy of excellence. We are relentless in our pursuit of knowledge and innovation, consistently seeking opportunities to refine our skills and knowledge. Through our diverse range of workshops, seminars, "
        "and exhibitions, we aim to share our Rover's progress and inspire fellow students across educational institutions nationwide. As a united front, we are driven by the spirit of exploration and discovery. With every challenge we tackle, every breakthrough we achieve, we move closer to the realization of our dream – a highly capable, "
        "adaptable, and resilient Mars Rover that can make its mark in the history of space exploration. Our commitment to pushing boundaries, fostering collaboration, and creating technological marvels sets us apart and defines the essence of the BRACU Mongol Tori Mars Rover Team.",
    imagePath: 'assets/projects/mongoltori.jpg',
  ),
  Project(
    title: 'Bracu Chondrobot',
    description: 'NASA had organized Second Annual Lunabotics Mining Competition on May 23-28, 2011.'
        ' It was a university-level competition designed to engage and retain students in science, technology, engineering and mathematics (STEM). '
        'NASA directly benefited from the competition by encouraging the development of innovative lunar excavation concepts from universities, which may result in clever ideas, and solutions,'
        ' which applied, to an actual lunar excavation device or payload. The challenge was to design remote controlled or autonomous excavators, or lunabots that have to collect and deposit lunar stimulant with '
        'some dimension and weight limitation. Initially 72 teams applied and around 48 teams from five countries, namely, the United States, Canada, India, Bangladesh and Columbia, participated for the 2011 competition. '
        'BRAC University team attended the competition for the first time from Bangladesh. The team members were Shiblee Imtiaz Hasan, Mohammad Jonayet Hossain, Kazi Mohammad Razin, Mahmudul Hasan Oyon and Md. Asifur Rahman, '
        'from the School of Engineering and Computer Science (SECS). Dr. Md. Khalilur Rahman, Dr. Mohammed Belal Hossain Bhuian and Dr. Md. Mosaddeque Rahman were the faculty advisors of this team. Eftakhar Karim Rahat, Imran Bin Jafar '
        'and Nirjhor Tahmidur Rouf were the volunteer participant of this project. BRAC University team named their robot as "BRACU_CHONDROBOT" which became a brand name with in a very short time. They were in NASA without having any major problems.'
        ' Their CHONDROBOT worked almost perfectly, even after traveling the half of the world. '
        'There were minor problems with some sensors but they could fix them in time. After having weight, dimension and communication inspection of course they got the opportunity to participate in final session. However, '
        'the power of motor was not enough for Lunar regolith simulate. In Bangladesh, they experimented in normal dust surface but the surface they found in lunarena was totally different. Anyway, they could grab a huge attention of NASA '
        'and their Medias because of their simple and cleaver design. Other Universities were surprised to know that they dont have any mechanical student and carried the whole robot as their luggage. '
        'After the competition, they had a good realization that the design and implementation was good enough for that event. So, if they can use this experience for future implementation, they will be able to get reasonable success.'
        ' McGill, Harvard University could not even participate in final session; most of the universities attended for the first time in this year, could not get good result (except the champion team). 48 teams got invitation to go to NASA, '
        '25 teams got opportunity to participate in final session and 13 teams only could collect reasonable lunar regolith. The ChondroBot team is wishing to attend again in the next year. So yes, ChondroBot does not end its journey here. '
        'For BRAC University, It was the end of the beginning in robotic world.',
    imagePath: 'assets/projects/chondrobot.jpg',
  ),
  Project(
    title: 'Bracu duburi',
    description: '‘BracU Duburi’ is believed to be Bangladesh’s first-ever autonomous underwater vehicle (AUV) to have participated in an international competition abroad.'
        ' It underwent a primary selection round among a pool of 46 rovers competing from 13 countries. '
        'The BRACU Duburi team is committed to establishing a vibrant and inclusive community of AUV and ROV hobbyists and enthusiasts who will collaborate to develop cutting-edge,'
        ' industrial-grade underwater vehicle. The team envisions fostering an environment where individuals can share their ideas, knowledge, and expertise to create innovative technologies'
        ' that can revolutionize the underwater industry. Additionally, the team aspires to establish a state-of-the-art test facility that will enable the next generation of ROV enthusiasts to '
        'hone their skills and advance their knowledge in the field. Through these initiatives, the BRACU Duburi team aims to create a sustainable and innovative ecosystem that will drive the growth and development of the underwater industry in Bangladesh and beyond.'
        'Duburi is composed of 7 sub teams which include Mechanical & 3D Design,AI & Autonomous,Sensor & Circuit,Control & Communication,Operations & Management,Research & Publication and Design & Outreach. These are tasked with different duties depending on the teams needs.',
    imagePath: 'assets/projects/duburi.jpg',
  ),
  Project(
    title: 'Bracu Ognibir',
    description: 'BRACU Ognibir is an innovative project aiming to develop a remote-controlled fire-fighting rover. '
        'Its purpose is to aid firefighters in accessing hazardous and inaccessible areas, enhancing safety and effectiveness. '
        'With current capabilities including wireless movement and water shooting, along with 2D mapping using an Ultra Sonic sensor, BRACU Ognibir serves as a solid foundation for future advancements. '
        'Planned upgrades include acquiring an industrial-grade nozzle and hose for improved water dispersal, '
        'integrating a thermal camera for autonomous action based on real-time heat detection, '
        'and incorporating LiDAR technology for accurate 2D mapping. These developments will significantly enhance firefighting capabilities,'
        ' making BRACU Ognibir an invaluable asset in critical firefighting operations in Bangladesh.',
    imagePath: 'assets/projects/ognibir.jpg',
  ),
  Project(
    title: 'Dr. Md. Khalilur Rahman',
    description: "Dr. Md. Khalilur Rahman is an Associate Professor of Computer Science and Engineering Department of BRAC University."
        " He was the principal investigator of Nation’s first Nano-satellite program which is named as “BRAC ONNESHA” by BRAC University."
        " He was assigned as the Acting Chairman of CSE department from 1st Sep-14 to 31st Dec-2014. He is the founder of Nano-Satellite Technology Research (NASTER) Lab,"
        " BRAC University Robotics lab and the founder advisor of BRAC University Robotics club."
        " The robot named CHONDROBOT, MONGOL-TORI and BRACU-DUBURI was designed and built under his peer supervision."
        " Different versions of these Robots are regularly attending in different international competitions such as NASA Lunabotic Mining Competition USA, University Rover Challenge USA, Singapore Autonomous Underwater Vehicle Competition etc."
        " Dr. Khalil has joined in BRAC University on 2009 immediately after completing his PhD degree from Kyushu Institute of Technology, Japan and promoted as associate professor on 2013."
        " He was a MONBUKAGAKUSHO scholar and his PhD Research topic was Natural Language Processing. "
        "But now his research is diverted into Space Science & Engineering, Robotics and Embedded Systems. "
        "He was born on 1976 in a river bank city Sirajganj of Bangladesh. After completing his Secondary and Higher Secondary Schooling he took admission in Institute of Science and Technology under National University for graduation and post-graduation degrees."
        " Dr. Khalil became point of contact (POC) of UNISEC-Global (University Space Engineering Consortium) on 2014. In his research and work he could build a very good relationship with government organizations like BTRC, SPARRSO, Atomic Energy Commission, CARGS, ICT Ministry etc. "
        "He is also a technical committee member of a Number of International conferences and Journals. He is an IEEE member."
        " S21KT is his amateur radio call sign.",
    imagePath: 'assets/projects/khalil sir.jpg',
  ),
];

Widget buildRoundedProjectButton(BuildContext context, Project project) {
  return Container(
    margin: EdgeInsets.all(10),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetail(
              title: project.title,
              description: project.description,
              imagePath: project.imagePath,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: project.imagePath,
            child: CircleAvatar(
              backgroundImage: AssetImage(project.imagePath),
              radius: 50,
            ),
          ),
          SizedBox(height: 5),
          Text(project.title),
        ],
      ),
    ),
  );
}

class ProjectDetail extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  ProjectDetail({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: imagePath,
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                description,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////