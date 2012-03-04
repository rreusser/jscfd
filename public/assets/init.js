((function(){$(document).ready(function(){var editor,editors,execute,runbutton,save,write_to_text_areas,_i,_len,_this=this;$(".header").noisy({intensity:.3}),$(".sidebar").noisy(),$(".tabselect").noisy(),this.myCodeMirror=new Object,editors=["snippet_functions","snippet_init","snippet_iteration"];for(_i=0,_len=editors.length;_i<_len;_i++)editor=editors[_i],this.myCodeMirror[editor]=CodeMirror.fromTextArea($("#"+editor)[0],{smartIndent:!1,lineNumbers:!0,matchBrackets:!0,fixedGutter:!0,onChange:function(){return $("#save").parent().addClass("needssave")}});return $("#tabpane .ltab").hide().eq(0).show(),$("#tabpane .tabselect").on("click","li",function(){var a;return a=$("#tabpane .tabselect li").index($(this)),$("#tabpane .ltab").eq(a).css("z-index",101).fadeIn(200,function(){return $("#tabpane .ltab").not(":eq("+a+")").css("z-index",99).hide(),$("#tabpane .ltab").eq(a).css("z-index",100)}),$("#tabpane .tabselect li").removeClass("active"),$(this).addClass("active")}),$("#plotpane .rtab").hide().eq(0).show(),$("#plotpane .tabselect").on("click","li",function(){var a;return a=$("#plotpane .tabselect li").index($(this)),$("#plotpane .rtab").eq(a).css("z-index",101).fadeIn(200,function(){return $("#plotpane .rtab").not(":eq("+a+")").css("z-index",99).hide(),$("#plotpane .rtab").eq(a).css("z-index",100)}),$("#plotpane .tabselect li").removeClass("active"),$(this).addClass("active")}),$(".sidebar").on("click","ul > li",function(){return $(this).children().not(":first-child").toggle(100),$(this).siblings().children().not(":first-child").hide(100)}),$(".sidebar ul li").children().not(":first-child").toggle(),save=function(){return write_to_text_areas(),$("#save").parent().removeClass("needssave"),$("#new_snippet, .edit_snippet").submit()},$("#save").click(function(){return save()}),write_to_text_areas=function(){var a,b,c,d;d=[];for(b=0,c=editors.length;b<c;b++)a=editors[b],d.push(document.myCodeMirror[a].save());return d},execute=function(code){if(code)return eval(code)},window.running=!1,window.initialized=!1,window.run=function(){if(window.initialized===!0){write_to_text_areas(),execute($(".iteration textarea")[0].value),window.Plotter.draw();if(window.running===!0)return setTimeout(function(){return window.run()},10)}},window.pause=function(){return console.log("Pausing"),window.running=!1,$("#init").removeClass("inactive")},window.step=function(){if(window.initialized===!0)return $("#init").removeClass("inactive"),window.running===!0?window.running=!1:(write_to_text_areas(),console.log("Steppping"),execute($(".iteration textarea")[0].value),window.Plotter.draw())},window.init=function(){return window.running===!1?($("#run").removeClass("inactive"),$("#pause").removeClass("inactive"),$("#step").removeClass("inactive"),window.Plotter.plotvarnames=[],window.Plotter.plotvars=[],write_to_text_areas(),console.log("Initializing"),execute($(".functions textarea")[0].value),execute($(".init textarea")[0].value),window.initialized=!0,window.Plotter.draw()):console.error("Please stop simulation before reinitializing.")},$("#init").click(function(){return init()}),$("#pause").click(function(){return pause()}),$("#step").parent().on("click","",function(){return window.step()}),$("#run").addClass("inactive"),$("#pause").addClass("inactive"),$("#step").addClass("inactive"),runbutton=function(){if(window.running===!1)return $("#init").addClass("inactive"),window.running=!0,window.run()},$("#run").parent().on("click","",function(){return runbutton()}),$(window).keydown(function(a){if(a.metaKey)switch(a.which){case 49:return a.preventDefault(),init();case 50:return a.preventDefault(),pause();case 51:return a.preventDefault(),step();case 52:return a.preventDefault(),runbutton();case 83:return a.preventDefault(),save()}})})})).call(this);