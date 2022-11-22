(function() {
// prettify Stata output using original IBM drawing characters to draw rules
// Germán Rodríguez <grodri@princeton.edu> (c) January 2014

	var ibmdc = ['─','│','┌','┬','┐','├','┼','┤','└','┴','┘'];
	
	var isvr = function(lines, j) {
		// determine if column is a vertical rule
		var nv = 0;
		var top = true;
		for(var i=0; i < lines.length; i++) {
			if(j >= lines[i].length) continue;
			var c = lines[i].charAt(j);
			if(c == ' ' && top) continue;
			var vr = c == '-' || c == '+' || c == '|';
			if(vr) { top = false; if(c == '|') nv++;}
			else if(c == ' ' && top) continue;		
			else if (i> 0 & i < lines.length-1) return false; // kludge to ignore first or last line
		}
		return nv > 0 && i >= lines.length;
	};

	var tablify = function(lines) {	
		// convert horizontal and vertical rules to drawing characters
	
		// find horizontal rules (contiguous -+| with at least ---)
		var hr = [];
		var w = 0;
		for(var i=0; i < lines.length; i++) {
			if(lines[i].length > w) w = lines[i].length;
			if(lines[i].match(/---/) != null) {
				hr.push(i);
			}
		}

		// find vertical rules (blanks then +-| with at least one |)
		var vr = [];
		for(var j=0; j < w; j++) {
			if(isvr(lines,j)) vr.push(j)
		}

		// convert horizontal rules (overwriting crossings)
		for(var k=0; k < hr.length; k++) {
			i = hr[k];
			var m = lines[i].match(/[-+|]+/);
			lines[i] = lines[i].substr(0,m.index) + Array(m[0].length+1).join(ibmdc[0]) + lines[i].substr(m.index+m[0].length);
			// try again in case there is a second rule (e.g. mata)
			var m = lines[i].match(/[-+|]+/);
			if (m == null || m[0].length < 3) continue;
			lines[i] = lines[i].substr(0,m.index) + Array(m[0].length+1).join(ibmdc[0]) + lines[i].substr(m.index+m[0].length);			}

		// convert vertical rules (fixing crossings)
		for(k=0; k < vr.length; k++) {
			j = vr[k];
			for(i = 0; i < lines.length; i++) {
				if(j >= lines[i].length) continue;
				c = lines[i].charAt(j);
				if(c == ' ') continue;
				var r = c;
				if( c == '|') {
					r = ibmdc[1];
				}
				else if (c== ibmdc[0]) { // was - or + converted to dash, map to 9 possible crossings
					var x = 6;	// rules above, below, left and right
					if(i == 0 || lines[i-1].charAt(j) != ibmdc[1]) 	    x -= 3; 		// not above
					if(i >= lines.length-1 || lines[i+1].charAt(j)!='|') x += 3; 		// not below
					if(j == 0 || lines[i].charAt(j-1) != ibmdc[0])       x -= 1; 		// not left
					if(j >= lines[i].length-1 || lines[i].charAt(j+1) != ibmdc[0]) x += 1; 	// not right		
					r = ibmdc[x];
				}
				lines[i] = lines[i].substr(0,j) + r + lines[i].substr(j+1);
			}
		}	
		return lines;
	};

	var getpars = function(lines) {
		// mark start and length of each paragraph
		var pars = [];
		var bot = 0;
		for(var i=0; i < lines.length; i++) {
			var empty = lines[i].length == 0 || lines[i].match(/^\s$/) != null;
			if (empty & i>bot) { pars.push([bot,i-bot]); bot = i+1;}
		}
		if (bot < lines.length) { pars.push([bot,lines.length-bot]); }
		return pars;
	};

	// select pre.stata blocks
	var blocks = document.querySelectorAll("pre.stata");
	for(var b=0; b < blocks.length; b++) {
		var changed = false;
	
		// split into lines and group by paragraph
		var lines = blocks[b].innerHTML.split('\n');
		var pars = getpars(lines);

		// tablify a paragraph (set of non-empty lines)
		for(var p=0; p < pars.length; p++) {
			var par = pars[p];
			var table = tablify(lines.slice(par[0],par[0]+par[1]));

			// replace lines that have changed
			for(var i=0; i < table.length; i++) {
				if(table[i] == lines[par[0]+i]) continue;
				lines[par[0]+i] = table[i];
				changed = true;
			}
		}
		if(changed) blocks[b].innerHTML = lines.join('\n');
	}
})();