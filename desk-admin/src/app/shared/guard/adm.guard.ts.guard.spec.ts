import { TestBed } from '@angular/core/testing';
import { CanActivateFn } from '@angular/router';

import { admGuardTsGuard } from './adm.guard.ts.guard';

describe('admGuardTsGuard', () => {
  const executeGuard: CanActivateFn = (...guardParameters) => 
      TestBed.runInInjectionContext(() => admGuardTsGuard(...guardParameters));

  beforeEach(() => {
    TestBed.configureTestingModule({});
  });

  it('should be created', () => {
    expect(executeGuard).toBeTruthy();
  });
});
