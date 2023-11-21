import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, RouterStateSnapshot, UrlTree } from '@angular/router';
import { map, Observable } from 'rxjs';
import { AuthService } from '../services/auth.services';
import { AdmUser } from '../services/user.services';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class AdmGuard {
  // AdmUser: any;
  constructor(
    private authService: AuthService,
    private AdmUser: AdmUser,
    private router: Router,
  ) { }

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {

    this.authService.isAdmin();

    let userDB: any;
    let user = JSON.parse(localStorage.getItem("user")!);

    return this.AdmUser.getUser(user.uid).pipe(
      map(user => {
        userDB = user.data();

        if (this.authService.isLoggedIn === false || userDB.admUser === false) {
          window.alert(`Você é um cliente ${user.id}, não é possível acessar esta página.`);
          this.router.navigate(['sign-in']);
          return false;
        }
        return true;
      }));
  }
}
