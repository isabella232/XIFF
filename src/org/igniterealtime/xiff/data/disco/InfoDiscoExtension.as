/*
 * License
 */
package org.igniterealtime.xiff.data.disco
{
	
	import flash.xml.XMLNode;
	
	import org.igniterealtime.xiff.data.ExtensionClassRegistry;
	import org.igniterealtime.xiff.data.IExtension;
	
	/**
	 * Implements <a href="http://xmpp.org/extensions/xep-0030.html">XEP-0030<a> for service info discovery.
	 * Also, take a look at <a href="http://xmpp.org/extensions/xep-0020.html">XEP-0020</a> and 
	 * <a href="http://xmpp.org/extensions/xep-0060.html">XEP-0060</a>.
	 *
	 * @param	parent (Optional) The XMLNode that contains this extension
	 */
	public class InfoDiscoExtension extends DiscoExtension implements IExtension
	{
		// Static class variables to be overridden in subclasses;
		public static const NS:String = "http://jabber.org/protocol/disco#info";
	
		private var myIdentities:Array;
		private var myFeatures:Array;
		
		public function InfoDiscoExtension(xmlNode:XMLNode = null)
		{
			super(xmlNode);
		}
		
		public function getElementName():String
		{
			return DiscoExtension.ELEMENT;
		}
	
		public function getNS():String
		{
			return InfoDiscoExtension.NS;
		}
	
	    /**
	     * Performs the registration of this extension into the extension registry.  
	     * 
	     */
	    public static function enable():void
	    {
	        ExtensionClassRegistry.register(InfoDiscoExtension);
	    }
	
		/**
		 * An array of objects that represent the identities of a resource discovered. For more information on
		 * categories, see <a href="http://www.jabber.org/registrar/disco-categories.html">
		 * http://www.jabber.org/registrar/disco-categories.html</a>
		 *
		 * The objects in the array have the following possible attributes:
		 * <ul>
		 * <li><code>category</code> - a category of the kind of identity</li>
		 * <li><code>type</code> - a path to a resource that can be discovered without a JID</li>
		 * <li><code>name</code> - the friendly name of the identity</li>
		 * </ul>
		 *
		 */
		public function get identities():Array
		{
			return myIdentities;
		}
	
		/**
		 * An array of namespaces this service supports for feature negotiation.
		 *
		 */
		public function get features():Array
		{
			return myFeatures;
		}
	
		override public function deserialize(node:XMLNode):Boolean
		{
			if (!super.deserialize(node))
				return false;
			
			myIdentities = [];
			myFeatures = [];
			
			for each(var child:XMLNode in getNode().childNodes) 
			{
				switch (child.nodeName) 
				{
					case "identity":
						myIdentities.push(child.attributes);
						break;

					case "feature":
						myFeatures.push(child.attributes["var"]);
						break;
				}
			}
			return true;
		}
	}
}