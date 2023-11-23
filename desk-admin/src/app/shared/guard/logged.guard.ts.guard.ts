import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from '../services/auth.services';

@Injectable({
  providedIn: 'root'
})
export class LoggedGuard{

  constructor(
    private authService: AuthService,
    private router: Router,
  ) {}


  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {

      if(this.authService.isLoggedIn === true){
        this.router.navigate(['dashboard']);
        return false;
      }
    return true;
  }
}
