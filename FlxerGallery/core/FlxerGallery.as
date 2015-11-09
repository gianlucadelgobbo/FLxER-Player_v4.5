﻿package FlxerGallery.core {	import flash.display.Sprite;   	import flash.events.*;	import FlxerGallery.core.FlxerPlayer;	import FlxerGallery.core.FlxerSelector;	import FlxerGallery.core.ThumbSaver;	import FlxerGallery.core.ThumbLoader;	import FlxerGallery.core.EndPage;	import FlxerGallery.main.DrawerFunc;	import Preferences;	import FlxerGallery.comp.ContextMenuExample;	import FlxerGallery.main.Txt;	public class FlxerGallery extends Sprite {		public var myToolbar;		public var mySuperPlayer;		public var mySelector;		public var myThumbSaver;		public var myThumbLoader;		public var myMenu;		public var myEndPage;		var testaH;		var piedeH;		public function FlxerGallery() {			// START TOOLBAR			this.myToolbar = new Toolbar();			Preferences.pref.testaH = myToolbar.testa.height;				Preferences.pref.testaY = myToolbar.testa.y;				Preferences.pref.piedeH = myToolbar.piede.piedeEst.height			if (Preferences.pref.standAlone) {				w = Preferences.pref.w;				h = Preferences.pref.h;			}			// START PLAYER			this.mySuperPlayer = new FlxerPlayer();			// START SELECTOR			this.mySelector = new FlxerSelector();			//			this.addChild(mySuperPlayer);			this.addChild(myToolbar);			this.addChild(mySelector);			this.myMenu = new Txt(3,0,100,300,"bella","puls");			this.myMenu.visible = false;			this.addChild(myMenu)		}		public function loadFooter() {			trace(parent.home.childNodes[0].childNodes[0].childNodes[3]);			this.myEndPage = new EndPage(parent.home,removeFooter);			if (Preferences.pref.maskera) {				this.mySuperPlayer.myMaskera.visible= false;			}			//new player(0,0,385,350,xml.childNodes[0].childNodes[0].childNodes[3],caricaPh)			this.addChild(myEndPage);		}		public function removeFooter(a) {			this.removeChild(myEndPage);			myToolbar.myPlaypause("");			if (Preferences.pref.maskera) {				this.mySuperPlayer.myMaskera.visible= true;			}		}		public function avvia() {			Preferences.pref.page_url = null;			myToolbar.fondo.removeEventListener(MouseEvent.MOUSE_DOWN, mySuperPlayer.vaiUserURL);			myToolbar.fondo.buttonMode=false;			if (parent.home.childNodes[0].childNodes.length == 1) {				Preferences.pref.single = true;			} else {				Preferences.pref.single = false;				this.myToolbar.mmSelTit = parseXml();			}			if (myEndPage is EndPage) {				if (this.contains(myEndPage)) {					this.removeChild(myEndPage);				}			}			if (Preferences.pref.autostop == true) {				if (Preferences.pref.single) {					mySuperPlayer.currMov = parent.home.childNodes[0].childNodes[0].childNodes[0].childNodes[0].toString();					this.myToolbar.avvia("player");					this.myToolbar.disable();					this.myToolbar.lab_i.htmlText = this.myToolbar.tit = parent.home.childNodes[0].childNodes[0].childNodes[1].childNodes[0].childNodes[0].toString();					this.myThumbLoader = new ThumbLoader(parent.home.childNodes[0].childNodes[0].childNodes[2].childNodes[0]);					this.removeChild(myToolbar);					this.addChild(myThumbLoader);					this.addChild(myToolbar);				} else {					this.myToolbar.avvia("selector");				}				parent.home.childNodes[0].attributes.autostop = "false"			} else {				mySuperPlayer.avvia(0);			}			if (Preferences.pref.thumbSaver) {				this.myThumbSaver = new ThumbSaver();				//this.myThumbSaver.removeChild(this.myThumbSaver.newT);				//this.myThumbSaver.addChild(this.myThumbSaver.shot);				this.addChild(myThumbSaver);				this.myThumbSaver.avvia();			}			if (!stage.hasEventListener(Event.RESIZE) && Preferences.pref.standAlone) {				//galleryResizer(null);				stage.addEventListener(Event.RESIZE, galleryResizer);			}		}		function parseXml() {			var flv=0;			var img=0;			var mp3=0;			var swf=0;			var str="";			//var txt="";			for (var a=0; a < parent.home.childNodes[0].childNodes.length; a++) {				//txt+= parent.home.childNodes[0].childNodes[a].childNodes[1].childNodes[0] + "\n";				var tmp=parent.home.childNodes[0].childNodes[a].childNodes[0].childNodes[0].toString();				tmp=tmp.substring(tmp.length - 3,tmp.length).toLowerCase();				if (tmp == "flv") {					flv++;				} else if (tmp == "mp3") {					mp3++;				} else if (tmp == "swf") {					swf++;				} else if (tmp == "jpg" || tmp == "png" || tmp == "gif") {					if (a == 0) {						firstIsImg=true;					}					img++;				}			}			if (flv > 0) {				str+= "VIDEO [" + flv + "] ";			}			if (mp3 > 0) {				str+= "AUDIO [" + mp3 + "] ";			}			if (swf > 0) {				str+= "SWF [" + swf + "] ";			}			if (img > 0) {				str+= "IMAGES [" + img + "] ";			}			if (img > 1) {				Preferences.pref.noImg=false;			}			return str;		}		public function galleryResizer(e) {			Preferences.pref.w = w = stage.stageWidth;			Preferences.pref.h = h = stage.stageHeight;			this.mySuperPlayer.setPos();			if (this.myThumbLoader is ThumbLoader && this.contains(this.myThumbLoader)) {				this.myThumbLoader.resizza();			}			if (this.myEndPage is EndPage && this.contains(this.myEndPage)) {				this.myEndPage.resizza();			}			this.myToolbar.setPos();			this.myMenu.x = w-this.myMenu.width-4;			this.myMenu.y = this.myToolbar.piede.y-this.myMenu.height;			if (!Preferences.pref.single && this.mySelector.visible) {				this.mySelector.setPos();			}		}		function menuSelectHandler(e) {			trace(e)		}	}}