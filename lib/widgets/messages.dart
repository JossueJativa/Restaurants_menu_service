import 'package:flutter/material.dart';

errorMessage(BuildContext context, String text){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: 
      Container(
        padding: const EdgeInsets.all(9.0),
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Row(
          children: [
            const Icon(Icons.do_disturb_on_rounded, color: Colors.black, size: 40,),
            const SizedBox(width: 20,),
            Expanded(child: 
              Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text,
                  style: const TextStyle(fontSize: 18, color: Colors.white,)),
                  const Spacer(),
                  const Text("MENSAJE DE ERROR!", style: TextStyle(
                    color: Colors.white, fontSize: 5
                  ), maxLines: 2, overflow: TextOverflow.ellipsis,)
                ],
              )
            )
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 15,
    )
  );
}

informationMessage(BuildContext context, String text){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: 
      Container(
        padding: const EdgeInsets.all(9.0),
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Row(
          children: [
            const Icon(Icons.info, color: Colors.black, size: 40,),
            const SizedBox(width: 20,),
            Expanded(child: 
              Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text,
                  style: const TextStyle(fontSize: 18, color: Colors.white,)),
                  const Spacer(),
                  const Text("MENSAJE DE INFORMACION", style: TextStyle(
                    color: Colors.white, fontSize: 5
                  ), maxLines: 2, overflow: TextOverflow.ellipsis,)
                ],
              )
            )
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 15,
    )
  );
}

successMessage(BuildContext context, String text){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: 
      Container(
        padding: const EdgeInsets.all(9.0),
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.black, size: 40,),
            const SizedBox(width: 20,),
            Expanded(child: 
              Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text,
                  style: const TextStyle(fontSize: 18, color: Colors.white,)),
                  const Spacer(),
                  const Text("MENSAJE DE EXITO", style: TextStyle(
                    color: Colors.white, fontSize: 5
                  ), maxLines: 2, overflow: TextOverflow.ellipsis,)
                ],
              )
            )
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 15,
    )
  );
}