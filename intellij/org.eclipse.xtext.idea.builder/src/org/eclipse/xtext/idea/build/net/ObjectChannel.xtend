/*******************************************************************************
 * Copyright (c) 2015 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.idea.build.net

import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import java.io.ObjectInputStream
import java.io.ObjectOutputStream
import java.io.Serializable
import java.nio.ByteBuffer
import java.nio.channels.ByteChannel
import java.nio.channels.ReadableByteChannel
import java.nio.channels.WritableByteChannel

import static java.lang.Math.*

/**
 * @author Jan Koehnlein - Initial contribution and API
 */
class ObjectChannel {
	
	public static val BUFFER_SIZE = 65536
	
	ByteBuffer inputBuffer = ByteBuffer.allocate(BUFFER_SIZE)
	ByteBuffer outputBuffer = ByteBuffer.allocate(BUFFER_SIZE)
	
	ReadableByteChannel inputChannel
	WritableByteChannel outputChannel

	new(ByteChannel channel) {
		this(channel, channel)
	}	
	
	new(ReadableByteChannel inputChannel, WritableByteChannel outputChannel) {
		this.inputChannel = inputChannel
		this.outputChannel = outputChannel
		inputBuffer.flip
	}
	
	def writeObject(Serializable o) {
		outputBuffer.clear
		val baos = new ByteArrayOutputStream()
		val oos = new ObjectOutputStream(baos)
		try {
			oos.writeObject(o)
			val bytes = baos.toByteArray
			outputBuffer.putInt(bytes.length)
			var offset = 0
			while(bytes.length - offset > 0) {
				var numBytes = min(outputBuffer.remaining, bytes.length-offset)
				outputBuffer.put(bytes, offset, numBytes)
				outputBuffer.flip
				while(outputBuffer.hasRemaining)
					outputChannel.write(outputBuffer)
				outputBuffer.clear
				offset += numBytes
			} 
		} finally {
			oos.close
		}
	}
	
	def Serializable readObject() {
		val length = ByteBuffer.wrap(readByteArray(4)).getInt(0)
		val ois = new ObjectInputStream(new ByteArrayInputStream(readByteArray(length)))
		try {
			return ois.readObject as Serializable
		} finally {
			ois.close
		}
	}
	
	protected def readByteArray(int numBytes) {
		val result = newByteArrayOfSize(numBytes)
		var offset = 0
		while(offset < numBytes) {
			if(inputBuffer.remaining > 0) {
				val availableBytes = min(numBytes - offset, inputBuffer.remaining)
				inputBuffer.get(result, offset, availableBytes)
				offset += availableBytes
			} else {
				inputBuffer.clear
				inputChannel.read(inputBuffer)
				inputBuffer.flip			
			}
		}
		result
	}
	
	def close() {
		inputChannel.close
		outputChannel.close
	}
}