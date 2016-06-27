yieldUnescaped '<!DOCTYPE HTMl>'
html{
	head{
		title('Format Hive Sql')
		meta(charset:'UTF-8')
		style(type:"text/css"){
			yield """
			   #codeTextarea{
			      width:500px;
			      height:510px;
			   }
			   .textAreaWithLines{
			      font-family:courier;      
			      border:1px solid #F00;
			      
			   }
			   .textAreaWithLines textarea,.textAreaWithLines div{
			      border:0px;
			      line-height:120%;
			      font-size:12px;
			   }
			   .lineObj{
			      color:gray;
			   }
		   """
	   }
	   
		   script(type:"text/javascript"){
		   		yieldUnescaped """
				   var lineObjOffsetTop = 2;
				   
				   function createTextAreaWithLines(id)
				   {
				      var el = document.createElement('DIV');
				      var ta = document.getElementById(id);
				      ta.parentNode.insertBefore(el,ta);
				      el.appendChild(ta);
				      
				      el.className='textAreaWithLines';
				      el.style.width = (ta.offsetWidth + 30) + 'px';
				      ta.style.position = 'absolute';
				      ta.style.left = '30px';
				      el.style.height = (ta.offsetHeight + 2) + 'px';
				      el.style.overflow='hidden';
				      el.style.position = 'relative';
				      el.style.width = (ta.offsetWidth + 30) + 'px';
				      var lineObj = document.createElement('DIV');
				      lineObj.style.position = 'absolute';
				      lineObj.style.top = lineObjOffsetTop + 'px';
				      lineObj.style.left = '0px';
				      lineObj.style.width = '27px';
				      el.insertBefore(lineObj,ta);
				      lineObj.style.textAlign = 'right';
				      lineObj.className='lineObj';
				      var string = '';
				      for(var no=1;no<ta.getAttribute("rows");no++){
				         if(string.length>0)string = string + '<br>';
				         string = string + no;
				      }
				      
				      ta.onkeydown = function() { positionLineObj(lineObj,ta); };
				      ta.onmousedown = function() { positionLineObj(lineObj,ta); };
				      ta.onscroll = function() { positionLineObj(lineObj,ta); };
				      ta.onblur = function() { positionLineObj(lineObj,ta); };
				      ta.onfocus = function() { positionLineObj(lineObj,ta); };
				      ta.onmouseover = function() { positionLineObj(lineObj,ta); };
				      lineObj.innerHTML = string;
				      
				   }
				   
				   function positionLineObj(obj,ta)
				   {
				      obj.style.top = (ta.scrollTop * -1 + lineObjOffsetTop) + 'px';   
				   }
				   
			   """
		}
	}
	body{
		header(role:'banner'){
			h1('Hive Sql语法检查、格式化')
		}
		div{
			form(action:'format_sql', method:'post'){
				textarea(rows:30, cols:100, name:'sql_text', id:"codeTextarea"){
					yield formated_sql
				}
				input(type:'submit', value:'格式化', id:'format_button')
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
		
		script(type:"text/javascript"){
   			yieldUnescaped """createTextAreaWithLines('codeTextarea');"""
   		}
		
		footer{
			p{
				yield 'Created By 想飞的鱼和会飞的水'
			}
		}
	}
}
