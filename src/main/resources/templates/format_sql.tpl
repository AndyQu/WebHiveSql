yieldUnescaped '<!DOCTYPE HTMl>'
html{
	head{
		title('Format Hive Sql')
		meta(charset:'UTF-8')
	}
	body{
		header(role:'banner'){
			h1('Hive Sql语法检查、格式化')
		}
		div{
			form(action:'format_sql', method:'get'){
				textarea(rows:30, cols:100, name:'sql_text'){
					yield formated_sql
				}
				input(type:'submit', value:'格式化')
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
		
		footer{
			p{
				yield 'Created By 想飞的鱼和会飞的水'
			}
		}
	}
}
