package forklang;

/**
 * Representation of a heap, which maps references to values.
 * 
 * @author hridesh
 *
 */
public interface Heap {

	Value ref (Value value);

	Value deref (Value.RefVal loc);

	Value setref (Value.RefVal loc, Value value);

	Value free (Value.RefVal value);

	static public class Heap16Bit implements Heap {
		private static final int HEAP_SIZE = 65_536;
		
		private Value[] _rep = new Value[HEAP_SIZE];
		private int index = 0;
		
		public synchronized Value ref (Value value) {
			if(index >= HEAP_SIZE)
				return new Value.DynamicError("Out of memory error");
			Value.RefVal new_loc = new Value.RefVal(index);
			_rep[index++] = value;
			return new_loc;
		}

		public synchronized Value deref (Value.RefVal loc) {
			try {
				return _rep[loc.loc()];
			} catch (ArrayIndexOutOfBoundsException e) {
				return new Value.DynamicError("Segmentation fault at access " + loc);
			}
		}

		public synchronized Value setref (Value.RefVal loc, Value value) {
			try {
				return _rep[loc.loc()] = value;
			} catch (ArrayIndexOutOfBoundsException e) {
				return new Value.DynamicError("Segmentation fault at access " + loc);
			}
		}

		public synchronized Value free (Value.RefVal loc) {
			try {
				_rep[loc.loc()] = null;
				//REMARK: students should add this location to free list.
				return loc;
			} catch (ArrayIndexOutOfBoundsException e) {
				return new Value.DynamicError("Segmentation fault at access " + loc);
			}
		}

		public Heap16Bit(){}
	}

}
