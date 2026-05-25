<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Clinic Routes
|--------------------------------------------------------------------------
|
| Here is where you can register clinic routes for the backend.
| These routes are loaded by the RouteServiceProvider.
|
*/

Route::prefix('clinic')->group(function () {
    Route::get('/', function () {
        return response()->json([
            'status' => 'success',
            'message' => 'Welcome to the Clinic module API endpoints.'
        ]);
    });
});
