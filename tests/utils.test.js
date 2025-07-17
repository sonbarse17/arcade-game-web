import { randomNumber, clamp, hexToRgb } from '../src/game/utils';

describe('Utility functions', () => {
  describe('randomNumber', () => {
    test('should return a number within the specified range', () => {
      const min = 1;
      const max = 10;
      const result = randomNumber(min, max);
      expect(result).toBeGreaterThanOrEqual(min);
      expect(result).toBeLessThanOrEqual(max);
    });
  });

  describe('clamp', () => {
    test('should return the value if it is within the range', () => {
      expect(clamp(5, 1, 10)).toBe(5);
    });

    test('should return the min value if the value is less than the min', () => {
      expect(clamp(0, 1, 10)).toBe(1);
    });

    test('should return the max value if the value is greater than the max', () => {
      expect(clamp(11, 1, 10)).toBe(10);
    });
  });

  describe('hexToRgb', () => {
    test('should return the correct RGB object for a valid hex code', () => {
      expect(hexToRgb('#ff0000')).toEqual({ r: 255, g: 0, b: 0 });
    });

    test('should return null for an invalid hex code', () => {
      expect(hexToRgb('not a hex')).toBeNull();
    });
  });
});
