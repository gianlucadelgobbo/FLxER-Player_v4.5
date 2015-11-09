﻿package FlxerGallery.core {	import flash.display.Sprite;	import flash.display.MovieClip;	import flash.utils.*;   	import flash.events.*;	import flash.net.*;	import flash.display.Shape;	import FlxerGallery.main.DrawerFunc;	import FLxER.core.Player;	public class FlxerPlayer extends Sprite {		var ssInt;		public var myloaded:Boolean;		public var h;		//		var fondo;		var myPlayer;		var myMask;		var index		var swf_status		public var currMov;		public var tmpTrgt		public var myMaskera;		public function FlxerPlayer() {			listaSS = [];			this.y = Preferences.pref.testaH+Preferences.pref.testaY;			h = Preferences.pref.h-(Preferences.pref.testaH+Preferences.pref.piedeH+Preferences.pref.testaY);			w = Preferences.pref.w			trace("Larghezza Schermo: "+w);			trace("Altezza Schermo: "+h);			if (Preferences.pref.playerBackground != undefined) {				fondo = new Sprite();				DrawerFunc.drawer(fondo,0,0,w,h,Preferences.pref.playerBackground,null,1);			} else {				trace("textureDrawertextureDrawertextureDrawertextureDrawertextureDrawertextureDrawertextureDrawertextureDrawertextureDrawertextureDrawertextureDrawertextureDrawertextureDrawertextureDrawertextureDrawertextureDrawertextureDrawertextureDrawertextureDrawertextureDrawer")				fondo = new Shape();				DrawerFunc.textureDrawer(fondo, w, h);			}			this.addChild(fondo);			this.myPlayer = new Player(1,w,h);			this.myMask = new Sprite();			DrawerFunc.drawer(myMask,0,0,w,h,0x000000,null,1);			//this.myPlayer.x = this.myMask.x = int(w/2);			//this.myPlayer.y = this.myMask.y = int(h/2);			this.addChild(myPlayer);			this.addChild(myMask);			this.myPlayer.mask = myMask;			if(Preferences.pref.maskera) {				this.myMaskera = new maskera();				this.addChild(myMaskera);			}			//}		}		public function avvia(i) {			if (myMaskera is maskera) {				if (this.contains(myMaskera)) {					this.myMaskera.avvia();				}			}			if (this.parent.myToolbar.hasEventListener(Event.ENTER_FRAME)) {				this.parent.myToolbar.removeEventListener(Event.ENTER_FRAME, this.parent.myToolbar["indice_"+Preferences.pref.tipo]);			}			var tmp = parent.parent.home.childNodes[0].childNodes[i].childNodes[0].childNodes[0].toString();			Preferences.pref.tipo = tmp.substring(tmp.lastIndexOf(".")+1, tmp.length).toLowerCase();			if (Preferences.pref.tipo == "png" || Preferences.pref.tipo == "gif") {				Preferences.pref.tipo = "jpg";				this.parent.myToolbar.piede.counter.lab.htmlText = "00 / 00";			} else {				if (Preferences.pref.tipo == "mp4") {					Preferences.pref.tipo = "flv";				}				this.parent.myToolbar.piede.counter.lab.htmlText = "00:00 / 00:00";			}			if (this.parent.myThumbLoader) {				if(this.parent.contains(this.parent.myThumbLoader)){					this.parent.removeChild(this.parent.myThumbLoader);				}			}			this.parent.myToolbar.setPos();			avviaCommon(i);			this["avvia_"+Preferences.pref.tipo](index);		}		public function avviaCommon(i) {			this.parent.myToolbar.avvia("player");			resetta();			this.visible = true;			index = i;			firstTime = true;			firstTime2 = true;			this.parent.myToolbar.disable();		}		public function avviaSS(i) {			if (this.parent.myToolbar.hasEventListener(Event.ENTER_FRAME)) {				this.parent.myToolbar.removeEventListener(Event.ENTER_FRAME, this.parent.myToolbar["indice_"+Preferences.pref.tipo]);			}			Preferences.pref.tipo = "jpg";			avviaCommon(i);			avvia_jpg(i);		}		public function resetta() {			//this.parent.myToolbar.resetta();			mbuto(getTimer()+",eject,0");			//myloaded = mcLoaded=swf_started=false;			l = 0;			n = 0;			clearInterval(this.ssInt);			this.visible = false;		}		public function mbuto(azione) {			trace("MMmbuto"+azione);			var myAction = azione.split(",");			this.myPlayer[myAction[1]](myAction);		}		/* SWF /////////////////*/		function avvia_swf(index) {			swf_status = false;			setLink(parent.parent.home.childNodes[0].childNodes[index].attributes.page_url);			var tmp = parent.parent.home.childNodes[0].childNodes[index].childNodes[0].childNodes[0].toString();			if (tmp.lastIndexOf("cnt=") != -1) {				tmp = tmp.substring(tmp.lastIndexOf("cnt=")+4, tmp.length);			}			load_swf(tmp);			//this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].toString();			this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].childNodes[0].toString();			this.parent.myToolbar.lab_i.htmlText = this.parent.myToolbar.tit;		}		/* TXT /////////////////*/		function avvia_txt(index) {			setLink(parent.parent.home.childNodes[0].childNodes[index].attributes.page_url);			Preferences.pref.txtFile = parent.parent.home.childNodes[0].childNodes[index].childNodes[0].childNodes[0].toString();			load_swf(Preferences.pref.myPath+"/_fp/reader.swf");			currMov = Preferences.pref.txtFile;			//this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].toString();			this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].childNodes[0].toString();			this.parent.myToolbar.lab_i.htmlText = this.parent.myToolbar.tit;		}		/* MP3 /////////////////*/		function avvia_mp3(index) {			setLink(parent.parent.home.childNodes[0].childNodes[index].attributes.page_url);			currMov = parent.parent.home.childNodes[0].childNodes[index].childNodes[0].childNodes[0].toString();			var currThumb = parent.parent.home.childNodes[0].childNodes[index].childNodes[2].childNodes[0].toString();			mbuto(getTimer()+",load_mp3,0,"+currMov+","+Preferences.pref.tipo+","+parent.myToolbar.piede.volume_ctrl.getVal()+","+currThumb);			//this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].toString();			this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].childNodes[0].toString();			this.parent.myToolbar.lab_i.htmlText = this.parent.myToolbar.tit;		}		public function initHandlerMP3(e) {			myPlayer.myStopStatus = false;			this.parent.myToolbar.piede.contr.playpause.simb.gotoAndStop(2);			this.parent.myToolbar.enable()			this.parent.myToolbar.avvia_indice();		}		/* FLV /////////////////*/		public function avvia_flv(index) {			/*if (parent.parent.home.childNodes[0].childNodes[index].attributes.page_url) {				setLink(parent.parent.home.childNodes[0].childNodes[index].attributes.page_url);			}*/			//this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].toString();			this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].childNodes[0].toString();			this.parent.myToolbar.lab_i.htmlText = this.parent.myToolbar.tit+": Buffering...";			var tmp = parent.parent.home.childNodes[0].childNodes[index].childNodes[0].childNodes[0].toString();			if (tmp.lastIndexOf("cnt=") != -1) {				tmp = tmp.substring(tmp.lastIndexOf("cnt=")+4, tmp.length);			}			currMov = tmp;			mbuto(getTimer()+",load_flv,0,"+currMov+","+parent.myToolbar.piede.volume_ctrl.getVal());		}		public function initHandlerFLV(event) {			trace(event.info.code);			switch (event.info.code) {				case "NetStream.Buffer.Full" :					if (firstTime2) {						firstTime2 = false;						this.parent.myToolbar.lab_i.htmlText = this.parent.myToolbar.tit;					}					break;				case "NetStream.Play.Start" :					if (firstTime) {						this.parent.myToolbar.enable()						this.parent.myToolbar.avvia_indice();						//resizza();						firstTime = false;						myPlayer.myStopStatus = false;						this.parent.myToolbar.piede.contr.playpause.simb.gotoAndStop(2);						//nsclosed = false;					}					//resizza();					break;				case "NetStream.Play.Stop" :					if (Preferences.pref.myLoop) {						myPlayer.NS.seek(0);					} else {						if (parent.parent.home.childNodes[0].childNodes.length>1) {							this.parent.myToolbar.avvia("selector");						} else {							myPlayer.NS.seek(0);							this.parent.myToolbar.myPlaypause(null);							if (Preferences.pref.endpage) {								this.parent.loadFooter();							}						}					}					break;				case "NetStream.Play.StreamNotFound" :					break;			}		}		/* IMMAGINI /////////////////*/		function avvia_jpg(index) {			listaSS = [];			generaListaSS();			for (var a = 0; a<listaSS.length; a++) {				if (parent.parent.home.childNodes[0].childNodes[index].childNodes[0].childNodes[0].toString() == parent.parent.home.childNodes[0].childNodes[listaSS[a]].childNodes[0].childNodes[0].toString()) {					index = a;				}			}			if (index != undefined || index == 0) {				this.parent.myToolbar.piede.contr.playpause.simb.gotoAndStop(2);				n = index;			} else {				this.parent.myToolbar.mRoot.customItems[0].enabled = true;			}			//this.parent.myToolbar.piede.indice.curs.puls.enabled = false;			load_foto();		}		function generaListaSS() {			for (var a = 0; a<parent.parent.home.childNodes[0].childNodes.length; a++) {				var tmp = parent.parent.home.childNodes[0].childNodes[a].childNodes[0].childNodes[0].toString();				tmp = tmp.substring(tmp.length-3, tmp.length).toLowerCase();				if (tmp == "jpg" || tmp == "png" || tmp == "gif") {					trace("cazzo");					listaSS.push(a);				}			}		}		public function load_prev_foto() {			if (n>1) {				n-=2;			} else if (n == 0) {				n = listaSS.length-2;			} else {				n = listaSS.length-1;			}			load_foto()		}		function setLink(xxx) {			if (xxx) {				if (xxx.length>0) {					Preferences.pref.page_url = xxx;					parent.myToolbar.fondo.addEventListener(MouseEvent.MOUSE_DOWN, vaiUserURL);					parent.myToolbar.fondo.buttonMode=true;				}			} else {				if (parent.myToolbar.fondo.hasEventListener(MouseEvent.MOUSE_DOWN)) {					parent.myToolbar.fondo.removeEventListener(MouseEvent.MOUSE_DOWN, vaiUserURL);				}				Preferences.pref.page_url = undefined;				parent.myToolbar.fondo.buttonMode=false;/**/			}		}		function loadNext() {			if (Preferences.pref.tipo == "jpg" && listaSS.length>0 && !this.parent.mySuperPlayer.myPlayer.myStopStatus) {				load_foto();			}		}		public function load_foto() {			this.parent.myToolbar.disable()			clearInterval(this.ssInt);			setLink(parent.parent.home.childNodes[0].childNodes[listaSS[n]].attributes.page_url);			var tmp = parent.parent.home.childNodes[0].childNodes[listaSS[n]].childNodes[0].childNodes[0].toString();			if (tmp.lastIndexOf("cnt=") != -1) {				tmp = tmp.substring(tmp.lastIndexOf("cnt=")+4, tmp.length);			}			currMov = tmp;			mbuto(getTimer()+",load_img,0,"+currMov+","+Preferences.pref.tipo+","+parent.myToolbar.piede.volume_ctrl.getVal());			if (parent.parent.home.childNodes[0].childNodes.length>1) {				this.parent.myToolbar.tit = (n+1)+" / "+listaSS.length+" - "+parent.parent.home.childNodes[0].childNodes[listaSS[n]].childNodes[1].childNodes[0].childNodes[0].toString();				this.parent.myToolbar.piede.counter.lab.htmlText = (n+1)+" / "+listaSS.length;				this.parent.myToolbar.piede.indice.curs.x = (((this.parent.myToolbar.barr_width)/(listaSS.length-1))*n);				l++;			} else {				this.parent.myToolbar.piede.counter.lab.htmlText = (n+1)+" / "+listaSS.length;				this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[listaSS[n]].childNodes[1].childNodes[0].childNodes[0].toString();			}			this.parent.myToolbar.lab_i.htmlText = this.parent.myToolbar.tit;		}		public function initHandlerJPG(trgt) {			clearInterval(this.ssInt);			if (listaSS.length>1) {				if (n>listaSS.length-2) {					if (Preferences.pref.myLoop) {						n = 0;						this.ssInt = setInterval(loadNext, Preferences.pref.ss_time);					} else {						this.ssInt = setInterval(avviaSelector, Preferences.pref.ss_time);					}				} else {					n++;					this.ssInt = setInterval(loadNext, Preferences.pref.ss_time);				}				this.parent.myToolbar.enable()				this.parent.myToolbar.piede.indice.curs.disable()			}		}		function load_swf(mov) {			currMov = mov;			mbuto(getTimer()+",load_movie,0,"+currMov+","+Preferences.pref.tipo+","+parent.myToolbar.piede.volume_ctrl.getVal());		}		function avviaSelector() {			clearInterval(this.ssInt);			this.parent.myToolbar.avviaSelector(null);		}		public function initHandlerSWF(trgt) {			if (Preferences.pref.tipo == "txt") {				trgt.avvia(Preferences.pref.txtFile)			}			swf_status = true;			myPlayer.myStopStatus = false;			if(trgt is flash.display.MovieClip) {				this.parent.myToolbar.piede.contr.playpause.simb.gotoAndStop(2);				this.parent.myToolbar.enable()				this.parent.myToolbar.piede.volume_ctrl.disable();				this.parent.myToolbar.avvia_indice();			}			resizza();		}		function setPos() {			h = Preferences.pref.h-(Preferences.pref.testaH+Preferences.pref.piedeH+Preferences.pref.testaY);			w = Preferences.pref.w;			if (Preferences.pref.playerBackground) {				fondo.width = myMask.width = w;				fondo.height = myMask.height = h;			} else {				DrawerFunc.textureDrawer(fondo, w, h);				myMask.width = w;				myMask.height = h;			}			//myPlayer.x = myMask.x = int(w/2);			//myPlayer.y = myMask.y = int(h/2);			//fondo.x = int(w/2);			//fondo.y = int(h/2);			myPlayer.resizza(w,h);		}		public function resizza_old(www=null,hhh=null) {			if (myMaskera is maskera) {				if (this.contains(myMaskera)) {					this.myMaskera.resizza();				}			}				//navigateToURL(new URLRequest("javascript:alert('width "+www+"')"));			if (myPlayer.oldTipo) {				h = Preferences.pref.h-(Preferences.pref.testaH+Preferences.pref.piedeH+Preferences.pref.testaY);				w = Preferences.pref.w				trace("cazzo"+myPlayer.oldTipo)				var item;				if (myPlayer.oldTipo == "flv") {					tmpTrgt = this.myPlayer.myVideo;					if (tmpTrgt.videoWidth) {						www = tmpTrgt.videoWidth						hhh = tmpTrgt.videoHeight					}				} else if (myPlayer.oldTipo == "jpg" || myPlayer.oldTipo == "mp3") {					tmpTrgt = this.myPlayer.imgToShow;				} else if (myPlayer.oldTipo == "swf" || myPlayer.oldTipo == "txt") {					tmpTrgt = this.myPlayer.swfTrgt;				}				//				if (Preferences.pref.resizza_onoff) {					if (myPlayer.oldTipo == "flv") {						if (www) {							/**/if ((www/hhh)>(w/h)) {								tmpTrgt.width = w								tmpTrgt.scaleY = tmpTrgt.scaleX;								trace(tmpTrgt.height);							} else {								tmpTrgt.height = h								tmpTrgt.scaleX = tmpTrgt.scaleY;							}							tmpTrgt.width = Math.round(tmpTrgt.width)							tmpTrgt.height = Math.round(tmpTrgt.height)/*							trace("OOOOOOOOOOOOOOOOOOOOOOOOOO "+www)							trace("OOOOOOOOOOOOOOOOOOOOOOOOOO "+hhh)							trace("OOOOOOOOOOOOOOOOOOOOOOOOOO "+(www/hhh))							trace("OOOOOOOOOOOOOOOOOOOOOOOOOO "+w)							trace("OOOOOOOOOOOOOOOOOOOOOOOOOO "+tmpTrgt.height)							trace("OOOOOOOOOOOOOOOOOOOOOOOOOO "+tmpTrgt.width)*/						}					} else if (myPlayer.oldTipo == "jpg" || myPlayer.oldTipo == "mp3") {						if ((tmpTrgt.width/tmpTrgt.height)>(w/h)) {							tmpTrgt.width = w							tmpTrgt.scaleY = tmpTrgt.scaleX;						} else {							tmpTrgt.height = h							tmpTrgt.scaleX = tmpTrgt.scaleY;						}						tmpTrgt.width = Math.round(tmpTrgt.width)						tmpTrgt.height = Math.round(tmpTrgt.height)					} else if (myPlayer.oldTipo == "swf" || myPlayer.oldTipo == "txt") {						if (swf_status) {							trace(tmpTrgt.scaleX)							tmpTrgt.scaleX = w/Preferences.pref.swfW;							tmpTrgt.scaleY = h/Preferences.pref.swfH;							if ((Preferences.pref.swfW/Preferences.pref.swfH)>(w/h)) {								tmpTrgt.scaleX = tmpTrgt.scaleY=(w/Preferences.pref.swfW);							} else {								tmpTrgt.scaleY = tmpTrgt.scaleX=(h/Preferences.pref.swfH);							}						}					}				} else {					if (myPlayer.oldTipo == "flv" && www) {						tmpTrgt = this.myPlayer.myVideo;						tmpTrgt.width = www;						tmpTrgt.height = hhh;					} else if (myPlayer.oldTipo == "jpg" || myPlayer.oldTipo == "mp3") {						tmpTrgt = this.myPlayer.imgToShow;					} else if (myPlayer.oldTipo == "swf" || myPlayer.oldTipo == "txt") {						this.myPlayer.swfTrgt.scaleY = this.myPlayer.swfTrgt.scaleX = 1;					}				}				if (Preferences.pref.centra_onoff) {					if (myPlayer.oldTipo == "swf" || myPlayer.oldTipo == "txt") {						if (swf_status) {							tmpTrgt.x = -(Preferences.pref.swfW*tmpTrgt.scaleX)/2;							tmpTrgt.y = -(Preferences.pref.swfH*tmpTrgt.scaleY)/2;							tmpTrgt.visible = true;						}					} else if (myPlayer.oldTipo == "jpg" || myPlayer.oldTipo == "flv" || myPlayer.oldTipo == "mp3") {						tmpTrgt.x = -int(tmpTrgt.width/2);						tmpTrgt.y = -int(tmpTrgt.height/2);						tmpTrgt.visible = true;					}				} else if (myPlayer.oldTipo == "jpg" || myPlayer.oldTipo == "flv" || myPlayer.oldTipo == "swf" || myPlayer.oldTipo == "txt" || myPlayer.oldTipo == "mp3") {					tmpTrgt.x = -int(w/2);					tmpTrgt.y = -int(h/2);					tmpTrgt.visible = true;				}			}				//navigateToURL(new URLRequest("javascript:alert('width "+tmpTrgt.width+"\\nheight "+tmpTrgt.height+"\\nparent.x "+tmpTrgt.parent.x+"\\nparent.y+ "+tmpTrgt.parent.y+"\\nx "+tmpTrgt.x+"\\ny "+tmpTrgt.y+"')"));		}		public function vaiUserURL(t) {			navigateToURL(new URLRequest(Preferences.pref.page_url),"_self")		}	}}