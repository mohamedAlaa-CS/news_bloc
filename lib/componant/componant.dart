import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';


Widget builArticalItem ( artical)=>Padding(
  padding:  EdgeInsets.all(20),
  child: Row(
    children: [
      Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
               '${artical['urlToImage']}'
            ),
          ),
        ),
      ),
      const  SizedBox(
        width: 20,
      ),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                    '${artical['title']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  )),
              Text('${artical['publishedAt']}',
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      )
    ],
  ),
);


Widget myDivider ()=>  Padding(
  padding: EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget articalBuilder (list)=>             ConditionalBuilder(
  condition:  list.length>0 ,
  builder: (context)=> ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index)=> builArticalItem(list[index]),
    separatorBuilder: (context , index) => myDivider(),
    itemCount: 10
    ,),
  fallback: (context)=> const Center(child: CircularProgressIndicator()),
);

