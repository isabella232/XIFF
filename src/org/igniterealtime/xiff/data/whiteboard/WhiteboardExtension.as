/*
 * License
 */
package org.igniterealtime.xiff.data.whiteboard
{

	
	import org.igniterealtime.xiff.data.IExtension;
	import org.igniterealtime.xiff.data.ISerializable;
	
	import org.igniterealtime.xiff.data.Extension;
	import org.igniterealtime.xiff.data.ExtensionClassRegistry;
	
	import org.igniterealtime.xiff.data.whiteboard.Path;
	import flash.xml.XMLNode;
	
	 
	/**
	 * A message extension for whitboard exchange. This class is the base class
	 * for other extension classes such as Path
	 *
	 * All child whiteboard objects are contained and serialized by this class
	 */
	public class WhiteboardExtension extends Extension implements IExtension, ISerializable
	{
		// Static class variables to be overridden in subclasses;
		public static var NS:String = "xiff:wb";
		public static var ELEMENT:String = "x";
	
	    private static var staticDepends:Class = ExtensionClassRegistry;
	
	    private var myPaths:Array;
		
		public function WhiteboardExtension( parent:XMLNode=null )
		{
			super( parent );
	        myPaths = [];
		}
	
		/**
		 * Gets the namespace associated with this extension.
		 * The namespace for the WhiteboardExtension is "xiff:wb".
		 *
		 * @return The namespace
		 */
		public function getNS():String
		{
			return WhiteboardExtension.NS;
		}
	
		/**
		 * Gets the element name associated with this extension.
		 * The element for this extension is "x".
		 *
		 * @return The element name
		 */
		public function getElementName():String
		{
			return WhiteboardExtension.ELEMENT;
		}
		
		/**
		 * Serializes the WhiteboardExtension data to XML for sending.
		 *
		 * @param	parent The parent node that this extension should be serialized into
		 * @return An indicator as to whether serialization was successful
		 */
		public function serialize( parent:XMLNode ):Boolean
		{
	        getNode().removeNode();
	        var ext_node:XMLNode = XMLFactory.createElement(getElementName());
	        ext_node.attributes.xmlns = getNS();
	
	        for (var i:int=0; i < myPaths.length; ++i) {
	            myPaths[i].serialize(ext_node);
	        }
	
	        parent.appendChild(ext_node);
	
			return true;
		}
	
	    /**
	     * Performs the registration of this extension into the extension registry.  
	     * 
	     */
	    public static function enable():void
	    {
	        ExtensionClassRegistry.register(WhiteboardExtension);
	    }
		
		/**
		 * Deserializes the WhiteboardExtension data.
		 *
		 * @param	node The XML node associated this data
		 * @return An indicator as to whether deserialization was successful
		 */
		public function deserialize( node:XMLNode ):Boolean
		{
			setNode( node );
	        myPaths = [];
			
	        for (var i:int=0; i < node.childNodes.length; ++i) {
	            var child:XMLNode = node.childNodes[i];
	            switch (child.nodeName) {
	                case "path":
	                    var path:Path = new Path();
	                    path.deserialize(child);
	                    myPaths.push(path);
	                    break;
	            }
	        }
			return true;
		}
	
	    /**
	     * The paths available in this whiteboard message
	     *
	     */
	    public function get paths():Array { return myPaths; }
	
	}
}