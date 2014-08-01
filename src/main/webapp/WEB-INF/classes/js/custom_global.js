function alertObjectReflection(obj) {
	var reflection = "*** Object reflection ***\n[typeof: " + typeof(obj) + "]\n";
	reflection += "[toString(): " + obj.toString() + "]\n";
	var propNameArray = [];
	var ownPropNameArray = [];
   
	reflection += "\n <properties - inherit> \n";
	for(var propName in obj) {
		if(typeof(obj[propName]) != "undefined" && typeof(obj[propName]) != "function" && !obj.hasOwnProperty(propName)) {
			propNameArray.push(propName);
		}
	}

	if (propNameArray.length == 0 ) {
		reflection += "no inherit properties";
	} else {
		propNameArray.sort();
	   	for(var v in propNameArray) {
	   		reflection += (propNameArray[v] + ", ");
	   	}
	   	reflection = reflection.substring(0, reflection.length - 2);
	}
	
	reflection += "\n\n <properties - own> \n";	   
	for(var propName in obj) {
		if(typeof(obj[propName]) != "undefined" && typeof(obj[propName]) != "function" && obj.hasOwnProperty(propName)) {
			ownPropNameArray.push(propName);
		}
	}
   
   if (ownPropNameArray.length == 0 ) {
	   reflection += "no own properties";
   } else {
	   ownPropNameArray.sort();
	   for(var v in ownPropNameArray) {
		   reflection += (ownPropNameArray[v] + ", ");
	   }
	   reflection = reflection.substring(0, reflection.length - 2);
   }
   
   var methodNameArray = [];
   
   for(var method in obj) {
		if(typeof(obj[method]) == "function") {
			methodNameArray.push(method);
		}
   }
	
   reflection += "\n\n <methods> \n";
   if (methodNameArray.length == 0 ) {
	   reflection += "no inherit methods";
   } else {
	   methodNameArray.sort();
	   for(var v in methodNameArray) {
		   reflection += (methodNameArray[v] + ", ");
	   }
	   reflection = reflection.substring(0, reflection.length - 2);
   }

   alert(reflection);
};

function getExtension(fileName) {
	var dotPosition = fileName.lastIndexOf('.');		
	if (-1 != dotPosition && fileName.length - 1 > dotPosition) {
		return fileName.substring(dotPosition + 1).toLowerCase();
	} else {
		return undefined;
	}
};