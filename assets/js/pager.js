// pager - revised version - G. Rodríguez - October 2022
//
var toc = {}
toc.title = window.location.href.indexOf("notes") < 0 ? "Computing Logs":
    "<img src='/images/html5.png'/> Chapters and Sections in HTML Format";
toc.parse = function() {
// makes a list of pages    
    toc.pages = [];
    for(i=0; i < toc.chapters.length; i++) {  
        var chapter = toc.chapters[i]   
        for(j=0; j < chapter.sections.length; j++) { 
            var section = chapter.sections[j]
            toc.pages.push({url:section.url, title: section.title})
        }
    }
}
toc.pager = function() {
    // pager has been rendered in layout.
    var target = window.location.href.split("/").slice(-1)[0];
    target = target.replace("#","");
    toc.parse();
    idx = toc.pages.findIndex(item => item.url == target);
    // previous
    var pp = $("#pager_previous")
    if(idx == 0) pp.hide();
    else {
        var previous = toc.pages[idx-1];
        pp.attr("href", previous.url);
        pp.attr("title", previous.title);
    }
    // next
    var pn = $("#pager_next");
    if(idx == toc.pages.length-1) pn.hide();
    else {
        var next = toc.pages[idx+1];
        pn.attr("href", next.url);
        pn.attr("title", next.title);
    }
}
toc.pager_old = function () {
 // render a pager with previous, toc, next
    // use window location href
    var target = window.location.href.split("/").slice(-1);
    toc.parse();
    idx = toc.pages.findIndex(item => item.url == target);    
    m = [];
    m.push('<div class="btn-group btn-group-sm">')    ;
    // previous
    if(idx > 0) {
        var previous = toc.pages[idx-1];
        m.push('<a class="btn btn-default" href="' + previous.url + 
            '" title="' + previous.title + '">');
        m.push('<i class="glyphicon glyphicon-triangle-left"></i></a>');
    }
    // toggle
    m.push('<button type="button" class="btn btn-default" data-toggle="collapse" data-target="#toc">');
    m.push('<i class="glyphicon glyphicon-menu-hamburger"></i>');
	m.push('</button>');
    // next
    if(idx < toc.pages.length-1) {
        var next = toc.pages[idx+1];
        m.push('<a class="btn btn-default" href="' + next.url + 
            '" title="' + next.title + '">');
        m.push('<i class="glyphicon glyphicon-triangle-right"></i></a>');
    }
    m.push('</div>');
    $("#pager").html(m.join('\n'));
    //
    // continue with
    var button = 'Continue with <button type="button" class="btn btn-default btn-sm">' +
            next.title + '</button>';
    $("#next").html(button);
}
// --------------------------------------------------------------
// toc
toc.accordion = function() {
// make an accordion 
	var m = [];
	m.push('<div class="list-group panel">');
    // need text-align:center for parent of .toc 
	m.push('<div class="list-group-item"><span class="toc">' + 
      toc.title + '</span>' + toc.button() + '</div>');
	for(var i=0; i < toc.chapters.length; i++) {
		var chapter = toc.chapters[i];
		m.push('<a href="#c_' + i + '" class="list-group-item toc-chapter" data-toggle="collapse" data-parent="#toc">');
		m.push(chapter.title);
		m.push('<span class="caret pull-right"></span></a>');
		m.push('<div id="c_' + i + '"  class="collapse">');
		for(var j=0; j < chapter.sections.length; j++) {
			var section = chapter.sections[j];
			m.push('<a href="' + section.url + '" class="list-group-item toc-section">');
			m.push(section.title);
			m.push("</a>");
		}
		m.push('</div>');		
	}
	m.push('</div>');  
	return m.join('\n');
}

toc.panel = function() {
// make a two-column panel
	var m = [];
//	m.push('<div id="toc" class="collapse">');
	m.push('<div class="panel panel-default">');
	m.push('<div class="panel-heading text-center">');
	m.push('<span class="toc">' + toc.title + toc.button() + '</div>');
	m.push('<div class="panel-body">');
	m.push('<div class="row">');
	m.push('<div id="toc-left" class="col-sm-6"></div>');
	m.push('<div id="toc-right" class="col-sm-6"></div>');
	m.push('</div>'); //roow
	m.push('</div></div>'); // body panel
	return m.join('\n');
}
toc.split = function() {
// split at a chapter or section 
    var n = 0;
    half = (2*toc.chapters.length - 1 + toc.pages.length)/2;
    for(i=0; i < toc.chapters.length; i++){
        if(i > 0) n = n + 2;
        if (n >= half) return {c:i, s:-1};
        var chapter = toc.chapters[i];        
        for(j=0; j < chapter.sections.length; j++) {
            n = n + 1;
            if(n >= half) return {c:i, s:j};
        }
    }
    return {c:-1, s:-1};
}
toc.fill = function() {
// render panel using split to left and right    
    var left = [];
    var right = [];
    var m = left; // need an argument to detect chapter
    var shift = function(chapter) {
        if(!chapter) m.push("</p>")
        m = right;
        if(!chapter) m.push("<p>");
    }
    var split = toc.split();	
    if(split.s == 0) split.s = -1; // avoid just chapter.
    for(var i=0; i < toc.chapters.length; i++) {
        if(split.c == i & split.s < 0) shift(true);
        var chapter = toc.chapters[i];
        m.push('<p><span class="toc-chapter">' + chapter.title + '</span><br>');
        for(var j=0; j < chapter.sections.length; j++) {
            if(split.c == i & split.s == j) shift(false);
            var section = chapter.sections[j]
            m.push('<a href="' + section.url + '" class="toc-section">');
			m.push(section.title + '</a><br/>');            
        }
        m.push("</p>")
    }
     $("#toc-left").html(left.join("\n"));
     $("#toc-right").html(right.join("\n"));    
}
toc.render = function() {
// inject toc div and render using panel or accordion
    var heading = $($("h1, h2, h3")[0]);
    heading.after('<p class="clearfix"></p><div id="toc" class="collapse"></div>')
    var w = $(window).width();
    if(w < 768) {
        $("#toc").html(toc.accordion());
    }
    else {
        $("#toc").html(toc.panel());
        toc.fill();
    }
}
toc.button = function() {
 // add a close button
    return '<button type="button" class="close pull-right"' +
        ' onclick="toc.close()">&times;</button>';
}
toc.close = function() {
 // do close    
    $("#toc").collapse("hide");
}
