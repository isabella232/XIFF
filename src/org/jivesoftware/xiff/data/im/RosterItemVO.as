package org.jivesoftware.xiff.data.im
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.core.IPropertyChangeNotifier;
	import mx.events.PropertyChangeEvent;
	
	import org.jivesoftware.xiff.core.JID;
	import org.jivesoftware.xiff.core.XMPPConnection;
	import org.jivesoftware.xiff.data.Presence;
	
	public class RosterItemVO extends EventDispatcher implements IPropertyChangeNotifier
	{
		private static var allContacts:Object = {};
		private var _jid:JID;
		private var _displayName:String;
		private var _groups:Array = [];
		private var _askType:String;
		private var _subscribeType:String;
		private var _status:String;
		private var _show:String;
		private var _priority:Number;
		
		public function RosterItemVO(newJID:JID):void 
		{
			jid = newJID;
		}
		
		public static function get(jid:JID, create:Boolean, connection:XMPPConnection=null):RosterItemVO
		{
			if(!connection)
			{
				var connections:Array = XMPPConnection.openConnections;
				if(connections.length > 0)
					connection = connections[0]; //default to the first open connection
				else
					throw new Error("Can't create RosterItemVOs with no active connection");
			}
			var bareJID:String = jid.toBareJID();
			var item:RosterItemVO = allContacts[connection.jid.toBareJID() + bareJID];
			if(!item && create)
				allContacts[connection.jid.toBareJID() + bareJID] = item = new RosterItemVO(jid);
			return item;
		}
		
		public function set uid(i:String):void
		{
			
		}
		
		public function get uid():String
		{
			return _jid.toString();
		}
		
		public function set subscribeType(newSub:String):void
		{
			var oldSub:String = subscribeType;
			_subscribeType = newSub;
			PropertyChangeEvent.createUpdateEvent(this, "subscribeType", oldSub, subscribeType);
		}
		
		[Bindable]
		public function get subscribeType():String
		{
			return _subscribeType;
		}
		
		public function set priority(newPriority:Number):void
		{
			var oldPriority:Number = priority;
			_priority = newPriority;
			PropertyChangeEvent.createUpdateEvent(this, "priority", oldPriority, priority);
		}
		
		[Bindable]
		public function get priority():Number
		{
			return _priority;
		}
		
		public function set askType(aT:String):void
		{
			var oldasktype:String = askType;
			var oldPending:Boolean = pending;
			_askType = aT;
			dispatchEvent(new Event("changeAskType"));
			PropertyChangeEvent.createUpdateEvent(this, "askType", oldasktype, askType);
			PropertyChangeEvent.createUpdateEvent(this, "pending", oldPending, pending);
		}
		
		[Bindable]
		public function get askType():String
		{
			return _askType;	
		}
		
		public function set status(newStatus:String):void
		{
			var oldStatus:String = status;
			_status = newStatus;
			PropertyChangeEvent.createUpdateEvent(this, "status", oldStatus, status);
		}
		
		[Bindable]
		public function get status():String
		{
			if(show == Presence.SHOW_OFFLINE)
				return Presence.SHOW_OFFLINE;
			return _status ? _status : "Available";
		}
		
		public function set show(newShow:String):void
		{
			// By default, normal isn't specified, so if null, we will use NORMAL
			newShow = newShow != null ? newShow : Presence.SHOW_NORMAL;
			var oldShow:String = show;
			_show = newShow;
			PropertyChangeEvent.createUpdateEvent(this, "show", oldShow, show);
		}
		
		[Bindable]
		public function get show():String
		{
			return _show;
		}
		
		public function set jid(j:JID):void
		{
			var oldjid:JID = _jid;
			_jid = j;
			//if we aren't using a custom display name, then settings the jid updates the display name
			if(!_displayName)
				dispatchEvent(new Event("changeDisplayName"));
				
			PropertyChangeEvent.createUpdateEvent(this, "jid", oldjid, j);
		}
		
		[Bindable]
		public function get jid():JID
		{
			return _jid;
		}
		
		public function set displayName(name:String):void
		{
			var olddisplayname:String = displayName;
			_displayName = name;
			PropertyChangeEvent.createUpdateEvent(this, "displayName", olddisplayname, displayName);
			dispatchEvent(new Event("changeDisplayName"));
		}
		
		[Bindable(event=changeDisplayName)]
		public function get displayName():String
		{
			return _displayName ? _displayName : _jid.node;
		}
		
		[Bindable(event=changeAskType)]
		public function get pending():Boolean {
			return askType == RosterExtension.ASK_TYPE_SUBSCRIBE && (subscribeType == RosterExtension.SUBSCRIBE_TYPE_NONE || subscribeType == RosterExtension.SUBSCRIBE_TYPE_FROM);
		}
	    
	    public override function toString():String
	    {
	    	return jid.toString();
	    }
	}
}