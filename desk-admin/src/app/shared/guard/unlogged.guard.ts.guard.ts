import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot,RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from '../services/auth.services';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class UnloggedGuard {
  constructor(
    private authService: AuthService,
    private router: Router,
  ) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {
    
    if(this.authService.isLoggedIn !== true){
      this.router.navigate(['home']);
      return false;
    }
    return true;
  }
  
}
