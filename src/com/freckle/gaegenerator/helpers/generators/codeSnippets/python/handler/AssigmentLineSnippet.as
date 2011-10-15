package com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler
{
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	import com.freckle.gaegenerator.vo.SchemaPropVO;
	
	public class AssigmentLineSnippet
	{
	
		
		public static function generate(prop:SchemaPropVO, object:SchemaObjectVO):String{
			switch(prop.type.name){
				case "RatingProperty":
					return object.name.toLowerCase() + "." + prop.name + " = int(self.request.get('"+ prop.name +"'))\r";
					break;
				case "PostalAddressProperty":
					return object.name.toLowerCase() + "." + prop.name + " = db.PostalAddressProperty(self.request.get('"+ prop.name +"'))\r";
					break;
				case "PhoneNumberProperty":
					return object.name.toLowerCase() + "." + prop.name + " = db.PhoneNumber(self.request.get('"+ prop.name +"'))\r";
					break;
				case "LinkProperty":
					return object.name.toLowerCase() + "." + prop.name + " = db.Link(self.request.get('"+ prop.name +"'))\r";
					break;
				case "EmailProperty":
					return object.name.toLowerCase() + "." + prop.name + " = db.Email(self.request.get('"+ prop.name +"'))\r";
					break;
				case "CategoryProperty":
					return object.name.toLowerCase() + "." + prop.name + " = db.Category(self.request.get('"+ prop.name +"'))\r";
					break;
				case "GeoPtProperty":
					return object.name.toLowerCase() + "." + prop.name + " = db.GeoPt(self.request.get('"+ prop.name +"Lat'),self.request.get('"+ prop.name +"Long'))\r";
					break;
				case "IMProperty":
					return object.name.toLowerCase() + "." + prop.name + " = db.IM(self.request.get('"+ prop.name +"Protocol'),self.request.get('"+ prop.name +"Address'))\r";
					break;
				case "TimeProperty":
					return object.name.toLowerCase() + "." + prop.name + " = datetime.time(int(self.request.get('"+ prop.name +"Hour')),int(self.request.get('"+ prop.name +"Minute')),int(self.request.get('"+ prop.name +"Seconds')),int(self.request.get('"+ prop.name +"Microseconds')))\r";
					break;
				case "DateProperty":
					return object.name.toLowerCase() + "." + prop.name + " = datetime.date(int(self.request.get('"+ prop.name +"Year')),int(self.request.get('"+ prop.name +"Month')),int(self.request.get('"+ prop.name +"Day')))\r";
					break;
				case "DateTimeProperty":
					return object.name.toLowerCase() + "." + prop.name + " = datetime.datetime(int(self.request.get('"+ prop.name +"Year')),int(self.request.get('"+ prop.name +"Month')),int(self.request.get('"+ prop.name +"Day')),int(self.request.get('"+ prop.name +"Hour')),int(self.request.get('"+ prop.name +"Minute')),int(self.request.get('"+ prop.name +"Seconds')),int(self.request.get('"+ prop.name +"Microseconds')))\r";
					break;
				case "BooleanProperty":
					return object.name.toLowerCase() + "." + prop.name + " = bool(self.request.get('"+ prop.name +"'))\r";
					break;
				case "FloatProperty":
					return object.name.toLowerCase() + "." + prop.name + " = float(self.request.get('"+ prop.name +"'))\r";
					break;
				case "IntegerProperty":
					return object.name.toLowerCase() + "." + prop.name + " = int(self.request.get('"+ prop.name +"'))\r";
					break;
				case "UserProperty":
					return object.name.toLowerCase() + "." + prop.name + " = users.User(self.request.get('"+ prop.name +"'))\r";
					break;
				case "BlobProperty":
					var blobStr:String = "";
					
					blobStr += object.name.toLowerCase() + "." + prop.name + "Key = str(f.key())\r";
					return blobStr;
					break;
				default:
					return object.name.toLowerCase() + "." + prop.name + " = self.request.get('"+ prop.name +"')\r";
					break;
		}
	}
	}
}