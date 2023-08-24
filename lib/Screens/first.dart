import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_iti/Data/Cubits/GetNewsCubit/get_news_cubit.dart';
import 'package:news_app_iti/Data/Models/get_news_model.dart';
import 'package:news_app_iti/Data/Repository/get_new_repo.dart';

class FirScreen extends StatelessWidget {
  FirScreen({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: () async {
              context.read<GetNewsCubit>().getNews();
            },
            child: Text("Get Updated News")),
        SizedBox(
          height: 30,
        ),
        BlocBuilder<GetNewsCubit, GetNewsState>(
          builder: (context, state) {
            if (state is GetNewsInitial) {
              return Center(
                child: Text("Please press the button to get news"),
              );
            } else if (state is GetNewsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetNewsSuccess) {
              return Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            ' Lastes News',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 148,
                          ),
                          Text(
                            ' See All',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 14,
                              color: Color.fromARGB(255, 11, 4, 214),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_right_alt),
                            color: Color.fromARGB(255, 11, 4, 214),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.response.articles.length,
                        itemBuilder: (context, index) {
                          print(state.response.articles[index].urlToImage
                              .toString());
                          return Container(
                            margin: EdgeInsets.all(6),
                            width:
                                MediaQuery.of(context).size.width * 340 / 375,
                            height:
                                MediaQuery.of(context).size.height * 300 / 812,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(state
                                        .response.articles[index].urlToImage ??
                                    "https://media.istockphoto.com/id/1264074047/vector/breaking-news-background.jpg?s=612x612&w=0&k=20&c=C5BryvaM-X1IiQtdyswR3HskyIZCqvNRojrCRLoTN0Q="),
                                fit: BoxFit.fitWidth,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 95),
                                    Container(
                                      child: Text(
                                        state.response.articles[index].author ??
                                            "",
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900,
                                            color:
                                                Color.fromARGB(255, 4, 6, 174)),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        state.response.articles[index]
                                            .description,
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        ' “I’m going to say this very bluntly again,” he added. “Buy them\n  only if you’re prepared to lose all your money.”',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text("Somethinge went wrone"),
              );
            }
          },
        ),
      ],
    ));
  }
}



///////  API requests / HTTP request / Call API from Data base    /////


/*   
what came from API is called : JSON Object (map in dart)
Javascript object notation 


what is the API ?
- its a link: helps us to connect with data base
- we call the api to (post (takes a body) - get(takes a parameters) - update(takes body) - delete(takes parameters) ) to remote/online/hosted/cloud database

- composition of API: 

1- Domain/Base URL (Constant):   https://newsapi.org  ----> referes to the data base

2- End Point (var) : /v2/everything?q=tesla&from=2023-07-24&sortBy=publishedAt&apiKey=7c07f0c86d484b30a5af1289c531cff1
refers to a point inside the database 
- consists of params 



* The proccess at which we call an API -------> Request 
* The proccess at which the API Reply -------> Response  


* Response status :
  Status code is the number at which we know if the response success or not.

  Success (200s):
  * 200: success
  * 201: success ----> creation


  Failiure (400s-500s):
  (Bad request)
  (Back End)
  * 400 ---> bad request (username or password wronge - wronge Credintials)
  * 401 --->  UnAuth (when user has no access to the data base - user has no TOKEN - has Expired TOKEN)
  * 403 ---> Forbidden (to access a point in database that not related to you (member access group setting))
  * 404  -->  not found

  ------------

  Server Error(Dev OPS):
  * 500
  * 501
  




///// How to call an API ///// :

1-  Making a MODEL for the response :  Turn JSON to Dart/Model Object ----> to ease the access of the response data.
                                  ---- each response must have a MODEL ------


2- Repository: the class where which you call the API

3- Cubit : just to handle state management in UI

*/


