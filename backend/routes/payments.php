<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Payments Routes
|--------------------------------------------------------------------------
|
| Here is where you can register payments routes for the backend.
| These routes are loaded by the RouteServiceProvider.
|
*/

Route::prefix('payments')->group(function () {
    Route::get('/', function () {
        return response()->json([
            'status' => 'success',
            'message' => 'Welcome to the Payments module API endpoints.'
        ]);
    });
});
