package org.jbox2d.common;

import java.lang.reflect.Array;

public class BufferUtils {

    /**
     * Reallocate a buffer.
     *
     * @param <T>
     * @param klass
     * @param oldBuffer
     * @param oldCapacity
     * @param newCapacity
     * @return
     */
    public static <T> T[] reallocateBuffer(Class<T> klass, T[] oldBuffer, int oldCapacity,
            int newCapacity) {
        assert (newCapacity > oldCapacity);
        @SuppressWarnings("unchecked")
        T[] newBuffer = (T[]) Array.newInstance(klass, newCapacity);
        if (oldBuffer != null) {
            System.arraycopy(oldBuffer, 0, newBuffer, 0, oldCapacity);
        }
        for (int i = oldCapacity; i < newCapacity; i++) {
            try {
                newBuffer[i] = klass.newInstance();
            } catch (InstantiationException | IllegalAccessException e) {
                throw new RuntimeException(e);
            }
        }
        return newBuffer;
    }

    /**
     * Reallocate a buffer.
     *
     * @param oldBuffer
     * @param oldCapacity
     * @param newCapacity
     * @return
     */
    public static int[] reallocateBuffer(int[] oldBuffer, int oldCapacity, int newCapacity) {
        assert (newCapacity > oldCapacity);
        int[] newBuffer = new int[newCapacity];
        if (oldBuffer != null) {
            System.arraycopy(oldBuffer, 0, newBuffer, 0, oldCapacity);
        }
        return newBuffer;
    }

    /**
     * Reallocate a buffer.
     *
     * @param oldBuffer
     * @param oldCapacity
     * @param newCapacity
     * @return
     */
    public static float[] reallocateBuffer(float[] oldBuffer, int oldCapacity, int newCapacity) {
        assert (newCapacity > oldCapacity);
        float[] newBuffer = new float[newCapacity];
        if (oldBuffer != null) {
            System.arraycopy(oldBuffer, 0, newBuffer, 0, oldCapacity);
        }
        return newBuffer;
    }

    /**
     * Reallocate a buffer. A 'deferred' buffer is reallocated only if it is not
     * NULL. If 'userSuppliedCapacity' is not zero, buffer is user supplied and
     * must be kept.
     *
     * @param <T>
     * @param klass
     * @param buffer
     * @param userSuppliedCapacity
     * @param oldCapacity
     * @param newCapacity
     * @param deferred
     * @return
     */
    public static <T> T[] reallocateBuffer(Class<T> klass, T[] buffer, int userSuppliedCapacity,
            int oldCapacity, int newCapacity, boolean deferred) {
        assert (newCapacity > oldCapacity);
        assert (userSuppliedCapacity == 0 || newCapacity <= userSuppliedCapacity);
        if ((!deferred || buffer != null) && userSuppliedCapacity == 0) {
            buffer = reallocateBuffer(klass, buffer, oldCapacity, newCapacity);
        }
        return buffer;
    }

    /**
     * Reallocate an int buffer. A 'deferred' buffer is reallocated only if it
     * is not NULL. If 'userSuppliedCapacity' is not zero, buffer is user
     * supplied and must be kept.
     *
     * @param buffer
     * @param userSuppliedCapacity
     * @param oldCapacity
     * @param newCapacity
     * @param deferred
     * @return
     */
    public static int[] reallocateBuffer(int[] buffer, int userSuppliedCapacity, int oldCapacity,
            int newCapacity, boolean deferred) {
        assert (newCapacity > oldCapacity);
        assert (userSuppliedCapacity == 0 || newCapacity <= userSuppliedCapacity);
        if ((!deferred || buffer != null) && userSuppliedCapacity == 0) {
            buffer = reallocateBuffer(buffer, oldCapacity, newCapacity);
        }
        return buffer;
    }

    /**
     * Reallocate a float buffer. A 'deferred' buffer is reallocated only if it
     * is not NULL. If 'userSuppliedCapacity' is not zero, buffer is user
     * supplied and must be kept.
     *
     * @param buffer
     * @param userSuppliedCapacity
     * @param oldCapacity
     * @param newCapacity
     * @param deferred
     * @return
     */
    public static float[] reallocateBuffer(float[] buffer, int userSuppliedCapacity, int oldCapacity,
            int newCapacity, boolean deferred) {
        assert (newCapacity > oldCapacity);
        assert (userSuppliedCapacity == 0 || newCapacity <= userSuppliedCapacity);
        if ((!deferred || buffer != null) && userSuppliedCapacity == 0) {
            buffer = reallocateBuffer(buffer, oldCapacity, newCapacity);
        }
        return buffer;
    }

    /**
     * Rotate an array, see std::rotate
     *
     * @param <T>
     * @param ray
     * @param first
     * @param new_first
     * @param last
     */
    public static <T> void rotate(T[] ray, int first, int new_first, int last) {
        int next = new_first;
        while (next != first) {
            T temp = ray[first];
            ray[first] = ray[next];
            ray[next] = temp;
            first++;
            next++;
            if (next == last) {
                next = new_first;
            } else if (first == new_first) {
                new_first = next;
            }
        }
    }

    /**
     * Rotate an array, see std::rotate
     *
     * @param ray
     * @param first
     * @param new_first
     * @param last
     */
    public static void rotate(int[] ray, int first, int new_first, int last) {
        int next = new_first;
        while (next != first) {
            int temp = ray[first];
            ray[first] = ray[next];
            ray[next] = temp;
            first++;
            next++;
            if (next == last) {
                next = new_first;
            } else if (first == new_first) {
                new_first = next;
            }
        }
    }

    /**
     * Rotate an array, see std::rotate
     *
     * @param ray
     * @param first
     * @param new_first
     * @param last
     */
    public static void rotate(float[] ray, int first, int new_first, int last) {
        int next = new_first;
        while (next != first) {
            float temp = ray[first];
            ray[first] = ray[next];
            ray[next] = temp;
            first++;
            next++;
            if (next == last) {
                next = new_first;
            } else if (first == new_first) {
                new_first = next;
            }
        }
    }
}
