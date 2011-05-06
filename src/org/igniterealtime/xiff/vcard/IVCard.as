/*
 * Copyright (C) 2003-2011 Igniterealtime Community Contributors
 *   
 *     Daniel Henninger
 *     Derrick Grigg <dgrigg@rogers.com>
 *     Juga Paazmaya <olavic@gmail.com>
 *     Nick Velloff <nick.velloff@gmail.com>
 *     Sean Treadway <seant@oncotype.dk>
 *     Sean Voisen <sean@voisen.org>
 *     Mark Walters <mark@yourpalmark.com>
 * 
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.igniterealtime.xiff.vcard
{
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import org.igniterealtime.xiff.core.IXMPPConnection;
	import org.igniterealtime.xiff.core.UnescapedJID;
	import org.igniterealtime.xiff.data.IIQ;
	
	public interface IVCard extends IEventDispatcher
	{
		function handleVCard( iq:IIQ ):void;
		
		function saveVCard( connection:IXMPPConnection ):void;
		
		function get birthday():Date;
		function set birthday( value:Date ):void;
		
		function get description():String;
		function set description( value:String ):void;
		
		function get email():String;
		function set email( value:String ):void;
		
		function get extensions():Dictionary;
		
		function get formattedName():String;
		function set formattedName( value:String ):void;
		
		function get geographicalPosition():VCardGeographicalPosition;
		function set geographicalPosition( value:VCardGeographicalPosition ):void;
		
		function get homeAddress():VCardAddress;
		function set homeAddress( value:VCardAddress ):void;
		
		function get homeAddressLabel():String;
		function set homeAddressLabel( value:String ):void;
		
		function get homeTelephone():VCardTelephone;
		function set homeTelephone( value:VCardTelephone ):void;
		
		function get jid():UnescapedJID;
		function set jid( value:UnescapedJID ):void;
		
		function get loaded():Boolean;
		
		function get logo():VCardPhoto;
		function set logo( value:VCardPhoto ):void;
		
		function get mailer():String;
		function set mailer( value:String ):void;
		
		function get name():VCardName;
		function set name( value:VCardName ):void;
		
		function get nickname():String;
		function set nickname( value:String ):void;
		
		function get note():String;
		function set note( value:String ):void;
		
		function get organization():VCardOrganization;
		function set organization( value:VCardOrganization ):void;
		
		function get photo():VCardPhoto;
		function set photo( value:VCardPhoto ):void;
		
		function get privacyClass():String;
		function set privacyClass( value:String ):void;
		
		function get productID():String;
		function set productID( value:String ):void;
		
		function get revision():Date;
		function set revision( value:Date ):void;
		
		function get role():String;
		function set role( value:String ):void;
		
		function get sortString():String;
		function set sortString( value:String ):void;
		
		function get sound():VCardSound;
		function set sound( value:VCardSound ):void;
		
		function get timezone():Date;
		function set timezone( value:Date ):void;
		
		function get title():String;
		function set title( value:String ):void;
		
		function get uid():String;
		function set uid( value:String ):void;
		
		function get url():String;
		function set url( value:String ):void;
		
		function get version():String;
		function set version( value:String ):void;
		
		function get workAddress():VCardAddress;
		function set workAddress( value:VCardAddress ):void;
		
		function get workAddressLabel():String;
		function set workAddressLabel( value:String ):void;
		
		function get workTelephone():VCardTelephone;
		function set workTelephone( value:VCardTelephone ):void;
	}
}