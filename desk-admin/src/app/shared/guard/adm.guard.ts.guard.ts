import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, RouterStateSnapshot, UrlTree } from '@angular/router';
import { map, Observable } from 'rxjs';
import { AuthService } from '../services/auth.services';
import { UserServices } from '../services/user.services';
import { Router } from '@angular/router';
import { AngularFirestore } from '@angular/fire/compat/firestore';


@Injectable({
  providedIn: 'root'
})
export class AdmGuard {
  constructor(
    public authService: AuthService,
    // public userService: UserServices,
    public router: Router,
    private afs: AngularFirestore,
  ) { }

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {

    this.authService.isAdmin();

    let userDB: any;
    let user: any;

    user = JSON.parse(localStorage.getItem("user") || '{}');

    return this.afs.doc(`users/${JSON.parse(localStorage.getItem("user") || '{}').uid}`)
      .get().pipe(
        map(user => {
          userDB = user.data();
          if (this.authService.isLoggedIn === false || userDB.admUser === (false) || userDB.admUser === null) {
            this.router.navigate(['sign-in']);
            window.alert(`Você é um cliente, não é possível acessar esta página.`);
            return false;
          }
          return true;
        }));
  }
}
