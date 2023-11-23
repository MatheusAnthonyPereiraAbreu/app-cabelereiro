import { TestBed } from '@angular/core/testing';
import { CanActivateFn } from '@angular/router';

import { loggedGuardTsGuard } from './logged.guard.ts.guard';

describe('loggedGuardTsGuard', () => {
  const executeGuard: CanActivateFn = (...guardParameters) => 
      TestBed.runInInjectionContext(() => loggedGuardTsGuard(...guardParameters));

  beforeEach(() => {
    TestBed.configureTestingModule({});
  });

  it('should be created', () => {
    expect(executeGuard).toBeTruthy();
  });
});
