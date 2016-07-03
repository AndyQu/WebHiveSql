var lineObjOffsetTop = 2;
var MinTextAreaRows = 10;
var MainTextAreaCols = 50;
var prevTextAreaContent="";

function createTextAreaWithLines(textAreaid) {
	//create containerDiv
	var containerDiv = document.createElement('DIV');
	var textArea = document.getElementById(textAreaid);
	textArea.parentNode.insertBefore(containerDiv, textArea);
	containerDiv.appendChild(textArea);

	containerDiv.className = 'textAreaWithLines';
	textArea.style.position = 'absolute';
	textArea.style.left = '30px';
	containerDiv.style.height = (textArea.offsetHeight + lineObjOffsetTop) + 'px';
	containerDiv.style.overflow = 'hidden';
	containerDiv.style.position = 'relative';
	containerDiv.style.width = (textArea.offsetWidth + 30) + 'px';

	//create line 
	var lineObj = document.createElement('DIV');
	lineObj.setAttribute("id", "line");
	lineObj.style.position = 'absolute';
	lineObj.style.top = lineObjOffsetTop + 'px';
	lineObj.style.left = '0px';
	lineObj.style.width = '27px';
	lineObj.style.textAlign = 'right';
	lineObj.className = 'lineObj';
	containerDiv.insertBefore(lineObj, textArea);


	textArea.onkeydown = function() {
		positionLineObj(lineObj, textArea);
	};
	textArea.onmousedown = function() {
		positionLineObj(lineObj, textArea);
	};
	textArea.onscroll = function() {
		positionLineObj(lineObj, textArea);
	};
	textArea.onblur = function() {
		positionLineObj(lineObj, textArea);
	};
	textArea.onfocus = function() {
		positionLineObj(lineObj, textArea);
	};
	textArea.onmouseover = function() {
		positionLineObj(lineObj, textArea);
	};
	textArea.onkeyup = function() {
		if(textArea.value==prevTextAreaContent){
			return;
		}else{
			prevTextAreaContent=textArea.value;
		}
		var lineContent = '';
		var textlines = textArea.value.split("\n");
		var lineCount = textlines.length;
		var maxCharsOneLine = 0;
		for (var no = 1; no <= lineCount; no++) {
			lineContent = lineContent + no;
			lineContent = lineContent + '<br>';
			maxCharsOneLine = Math.max(maxCharsOneLine, textlines[no - 1].length);
		}
		maxCharsOneLine = Math.max(maxCharsOneLine + 1, MainTextAreaCols);
		lineCount = Math.max(lineCount + 1, MinTextAreaRows);

		textArea.rows = lineCount;
		textArea.style.height = lineCount + "em";
		textArea.style.width = maxCharsOneLine + "em";

		containerDiv.style.height = (textArea.offsetHeight + lineObjOffsetTop) + 'px';
		containerDiv.style.width = (textArea.offsetWidth + 30) + 'px';

		document.getElementById("line").innerHTML = lineContent;
	}
	textArea.onkeyup();
}

function positionLineObj(obj, ta) {
	obj.style.top = (ta.scrollTop * -1 + lineObjOffsetTop) + 'px';
}