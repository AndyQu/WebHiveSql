yieldUnescaped '<!DOCTYPE HTMl>'
html{
	head{
		title('Format Hive Sql'){}
		meta(charset:'UTF-8'){}
		link(rel: 'stylesheet', href:'/css/textarea.css'){}
	    script(src:"/js/textarea.js"){}
	}
	body{
		
		header(role:'banner'){
			h1('Hive Sql语法检查、格式化')
		}
		
		div{
			form(action:'format_sql', method:'post'){
				input(type:'submit', value:'格式化', id:'format_button')
				textarea(rows:10, cols:100, name:'sql_text', id:"codeTextarea"){
					yield formated_sql
				}
			}
		}
		
		div{
			ul{
				syntax_errors?.each{
					syntaxError->
						li{
							p{
								yield "可以考虑：添加字符${syntaxError.getExpectedTokenStrings()} 以补齐 ${syntaxError.getRuleName()}子句"
							}
						}
				}
			}
		}
		
		script{
   			yieldUnescaped """createTextAreaWithLines('codeTextarea');"""
   		}
		
		footer{
			p{
				yield 'Created By 想飞的鱼和会飞的水'
			}
		}
	}
}
