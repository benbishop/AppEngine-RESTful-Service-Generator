package com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler
{
	import com.freckle.gaegenerator.vo.SchemaObjectVO;

	public class RedirectSnippet
	{
		public function RedirectSnippet()
		{
			
		}
		
		public static function generate(vo:SchemaObjectVO):String{
			if(vo.parent != null){
				return "\t\t\tself.redirect(\"/"+vo.methodName+"?key=\"+str("+vo.name.toLowerCase()+".key()) + \"&"+vo.parent.name.toLowerCase()+"key=\" + str("+vo.name.toLowerCase()+"."+vo.parent.name.toLowerCase()+".key()))\r";
				
			}else{
				return "\t\t\tself.redirect(\"/"+vo.methodName+"?key=\"+str("+vo.name.toLowerCase()+".key()))\r"
			}
		}
		
	}
}